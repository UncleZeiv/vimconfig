" flag problematic whitespace (trailing and spaces before tabs)
function! ProblematicWhitespaceHighlights()
	highlight RedundantSpaces term=standout ctermbg=Grey guibg=#ffddcc
	highlight ConflictingIndent term=standout ctermbg=Red guibg=Red
endfunction

function! FlagProblematicWhitespace(evenWhenExists)
	if ! exists('w:redundantSpacesHighlight') || (w:redundantSpacesHighlight == 0 && a:evenWhenExists)
		let w:redundantSpacesHighlight = matchadd('RedundantSpaces', '\(\s\+$\| \+\ze\t\|\t\zs \+\)\(\%#\)\@!')
	endif
	if ! exists('w:conflictingIndentHighlight') || (w:conflictingIndentHighlight == 0 && a:evenWhenExists)
		let w:conflictingIndentHighlight = matchadd('ConflictingIndent', '\(^ \+.*\n\)\@<=\t\+\|\(^\t\+.*\n\)\@<= \+')
	endif
endfunction

function! UnflagProblematicWhitespace()
	if w:redundantSpacesHighlight != 0
		call matchdelete(w:redundantSpacesHighlight)
		let w:redundantSpacesHighlight = 0
	endif
	if w:conflictingIndentHighlight != 0
		call matchdelete(w:conflictingIndentHighlight)
		let w:conflictingIndentHighlight = 0
	endif
endfunction

function! ToggleFlagProblematicWhitespace()
	if (w:redundantSpacesHighlight + w:conflictingIndentHighlight == 0)
		call FlagProblematicWhitespace(1)
	else
		call UnflagProblematicWhitespace()
	endif
endfunction

call ProblematicWhitespaceHighlights()

autocmd VimEnter * silent! call FlagProblematicWhitespace(1)
autocmd WinEnter * silent! call FlagProblematicWhitespace(0)

noremap <S-F11> :call ToggleFlagProblematicWhitespace()<CR>
