" Miscellaneous utility scripts
" dave@kerid.org, 2010

" {{{ split function declaration
function! Kerid_SplitFunctionDeclaration()
	let v:errmsg = ""
	let start_pos = getpos('.')[1:2]
	normal ^
	if searchpos('(', '', line('.')) == [0, 0]
		" the line needs to have an open paren
		return
	endif
	if searchpairpos('(', '', ')', 'W') != [0, 0]
		" the close paren is not required, just move it out of the way together 
		" with everything that follow
		normal D
		put
		normal k
	endif
	silent! substitute/\s*$//
	silent! substitute/[(,<;]/\0\r/g
	if v:errmsg != ""
		return
	endif
	let end_line = line('.')
	call cursor(start_pos)
	" join lines if we splitted where a nested ( or < is
	while line('.') <= end_line
		normal j
		if match(getline('.'), '[(<]$') != -1
			normal $%
			let target = line('.') + 1
			normal %
			let lines_to_join = ( target - line('.') )
			execute 'normal' lines_to_join . 'J'
			let end_line = end_line - lines_to_join + 1
			normal k
		endif
	endwhile
	" reindent the entire block
	normal V
	call cursor(start_pos)
	normal =
	call cursor(start_pos)
endfunction
" }}}

" {{{ copy function declaration from definition
function! Kerid_FunctionDeclarationFromDefinition()
	" go at the beginning of the line
	normal ^
	let v:errmsg = ""
	" replace all namespace/classname tags before the function name
	silent! substitute/\m[a-zA-Z0-9_:]\+::\(\w\+\s*(\)\@=//
	if v:errmsg != ""
		return
	endif
	" add ; at the end
	normal $a;
	" add documentation comment
	normal O/**  */
	" correct indentation
	normal Vj=
	" position in the middle of the comment
	normal ^4l
	startinsert
endfunction
" }}}

" {{{ regex silly beautifier (avoids strings, now works with ranges!)
function! Kerid_SillyRegexBeautifier(start, end)

	function! Avoid_surroundings(before, pattern, after)
		return '\(' . a:before . '\)\@<!' . a:pattern . '\(' . a:after . '\)\@!'
	endfunction

	function! Avoid_preceding(before, pattern)
		return '\(' . a:before . '\)\@<!' . a:pattern
	endfunction

	let i = a:start
	while i <= a:end
		let line = getline(i)

		" ignore preprocessor directives
		if match(line, '^\s*#') == 0
			let i += 1
			continue
		endif

		" ignore content of strings, splitting at double quotes characters not 
		" preceded by escape characters
		let chunks = split(line, '\(\([^\\]\|^\)\\\(\\\\\)*\)\@<!"', 1)

		let c = 0
		for c in range(0, len(chunks), 2)

			let chunk = chunks[c]
			" add whitespace in couples
			let chunk = substitute(chunk, '[?({\[,]', '\0 ', 'g')
			let chunk = substitute(chunk, '[?)}\]]', ' \0', 'g')

			" less/greater than are both operators AND parens
			let chunk = substitute(chunk, '<\{1,2}=\=', ' \0 ', 'g')
			let chunk = substitute(chunk, '>\{1,2}=\=', ' \0 ', 'g')

			" add space after semi-colon if not at the end of line
			let chunk = substitute(chunk, ';\($\)\@!', '; ', 'g')

			" operators
			" +-&| not followed by themselves or equals
			" */ not followed by each other
			" let chunk = 'hello+something+=pippo*=zuco*zuco&&something||trullo,pippo++,pluto--'
			" let test = 'hello + something += pippo *= zuco * zuco && something || trullo,pippo++,pluto--'
			let chunk = substitute(chunk, Avoid_surroundings('+',    '+',  '+'   ) . '=\=', ' \0 ', 'g')
			let chunk = substitute(chunk, Avoid_surroundings('-',    '-',  '-'   ) . '=\=', ' \0 ', 'g')
			let chunk = substitute(chunk, Avoid_surroundings('[/*]', '/',  '[/*]') . '=\=', ' \0 ', 'g')
			let chunk = substitute(chunk, Avoid_surroundings('/',    '\*', '/'   ) . '=\=', ' \0 ', 'g')
			let chunk = substitute(chunk, '[|&]\{1,2}=\=', ' \0 ', 'g')
			let chunk = substitute(chunk, Avoid_preceding('[+\-*/|&<>]', '=\{1,2}'), ' \0 ', 'g')

			" remove from empty couples
			let chunk = substitute(chunk, '(\s\+)', '()', 'g')
			let chunk = substitute(chunk, '{\s\+}', '{}', 'g')
			let chunk = substitute(chunk, '<\s\+>', '<>', 'g')
			let chunk = substitute(chunk, '\[\s\+\]', '[]', 'g')

			" remove from square brackets if filled with digits
			let chunk = substitute(chunk, '\[\s*\(\d\+\)\s*\]', '[\1]', 'g')
			" fix errors
			let chunk = substitute(chunk, '\s*-\s*>\s*', '->', 'g')
			let chunk = substitute(chunk, '#include\s*<\s*\(\S*\)\s*>', '#include <\1>', 'g')

"			boost::shared_ptr< foo, bar >( hello );
"			boost::shared_ptr<foo,bar>(hello) != pippo
"			a<3&&4>(5+3)

			let chunk = substitute(chunk, '\s\+\(<[[:alnum:][:space:]<>:,_]*>\)\@=', '', 'g')
			let chunk = substitute(chunk, '\(<[[:alnum:][:space:]<>:,_]*>\)\@<=\s\+(', '(', 'g')
			let chunk = substitute(chunk, '!\s\+=', '!=', 'g')
			" space after if(chunk, 'for', 'while etc.
			let chunk = substitute(chunk, '\(if\|for\|while\|try\|catch\)(', '\1 (', 'g')
			" remove double spaces
			let chunk = substitute(chunk, ' \+', ' ', 'g')
			if c == 0
				" remove spaces before ) or } if added at the beginning of the line
				let chunk = substitute(chunk, '^\(\(\t\|\r\)*\) \+\([)}]\)\@=', '\1', 'g')
			endif

			let chunks[c] = chunk
		endfor

		let line = join(chunks, '"')

		" remove spaces at the end of the line
		let line = substitute(line, '\s\+$', '', '')

		call setline(i, line)

		let i += 1
	endw
endfunction
" }}}

" {{{ email stuff
function! Kerid_SplitHttpLinks()
	%substitute/\([^\r]\)http/\1\rhttp/ge
endfunction

function! Kerid_EmailFillHeaderLinks()
	" go to the top
	normal gg
	" delete the first three lines
	normal c3j
	" write header
	normal iSubject:   links 2010 week 
	read !date "+\%W"
	normal kJ
	normal iTo:        davide.vercelli@gmail.com
endfunction
" }}}

" {{{ rib files
function! Kerid_SplitShaderDeclarations()
	silent!  '<,'>substitute/" "/"\r\t"/g
	silent!  '<,'>substitute/] "/]\r\t"/g
	silent!  '<,'>substitute/] \n"/]\r\t"/g
endfunction
" }}}

" {{{ default mappings
if !exists("s:kerid_mappingsAlreadyDefined")
	let s:kerid_mappingsAlreadyDefined = 0
endif

if !exists("g:kerid_debugMode")
	let g:kerid_debugMode = 0
endif

if exists("g:kerid_defineMappings") && g:kerid_defineMappings == 1
	if s:kerid_mappingsAlreadyDefined == 0 || g:kerid_debugMode == 1
		nnoremap ,ff :call Kerid_SplitFunctionDeclaration()<CR>
		nnoremap ,fd :call Kerid_FunctionDeclarationFromDefinition()<CR>
		nnoremap ,sh :call Kerid_SplitHttpLinks()<CR>
		nnoremap ,eh :call Kerid_EmailFillHeaderLinks()<CR>
		nnoremap ,bf :call Kerid_SillyRegexBeautifier(0, line('$'))<CR>
		vnoremap ,bf :call Kerid_SillyRegexBeautifier(line("'<"), line("'>"))<CR>
		let s:kerid_mappingsAlreadyDefined = 1
	endif
endif
" }}}

" ------------------------------------------- vim:fdm=marker fdl=0 fdc=1 cms=%s
