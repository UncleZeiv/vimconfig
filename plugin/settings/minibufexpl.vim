" update after editing and/or saving files
" autocmd BufWritePost,InsertLeave * :UMiniBufExplorer

function! DefineMBEMatch(id, groupName, extensionList)
	call matchadd(a:groupName, '\(:\)\@<=[^\]]*\.\('.join(a:extensionList, '\|').'\)\(\]\)\@=', 10, a:id)
endfunction

function! DefineMatches()
	call matchadd('MBEDirectories', '^[^[].*$', 10, 7)
	call matchadd('MBEBufferId', '\d\+:\@=', 10, 9)
	call matchadd('MBEOthers', '\(:\)\@<=[^\]]\+\(\]\)\@=', 9, 8)
	call DefineMBEMatch(10, 'MBECpp', ['cpp', 'CPP', 'cc', 'CC'])
	call DefineMBEMatch(11, 'MBEHeader', ['h', 'H', 'hpp', 'HPP', 'HH'])
	call DefineMBEMatch(12, 'MBEPython', ['py'])
	call DefineMBEMatch(13, 'MBEVim', ['vim', 'vimrc', 'gvimrc'])
	call DefineMBEMatch(14, 'MBEScons', ['scons'])
	call DefineMBEMatch(15, 'MBERst', ['rst'])
	call DefineMBEMatch(16, 'MBEMel', ['mel'])
	call DefineMBEMatch(17, 'MBEGlsl', ['frag', 'vert', 'glsl', 'geom'])
	call DefineMBEMatch(18, 'MBEPatch', ['patch', 'diff'])
	call DefineMBEMatch(19, 'MBEText', ['txt', 'readme', 'README'])
	call DefineMBEMatch(20, 'MBEIgnore', ['[^.\]]\+\~'])
	call DefineMBEMatch(21, 'MBERib', ['rib'])
endfunction

if !exists("g:MiniBufExplDefineMatches")
	let g:MiniBufExplDefineMatches = function("DefineMatches")
endif

function! DefineMBEHighlights()
	highlight MBEDirectories    guifg=White guibg=DarkBlue ctermbg=Cyan ctermfg=Black
	highlight MBEOthers         guifg=fg " ctermfg=fg
	highlight MBENormal         guifg=bg guibg=bg " ctermfg=bg ctermbg=bg
	" TODO: ok here we should deal differently with hlsearch and incsearch...
	highlight MBEChanged        term=standout guibg=#ff7256    ctermbg=DarkRed    guifg=#ff7256    ctermfg=DarkRed
	highlight MBEVisibleNormal  term=standout guibg=Yellow     ctermbg=Yellow     guifg=Yellow     ctermfg=Yellow
	highlight MBEVisibleChanged term=standout guibg=DarkYellow ctermbg=DarkYellow guifg=DarkYellow ctermfg=DarkYellow

	highlight MBEBufferId guifg=#708090 ctermfg=Gray
	highlight MBECpp      guifg=#4169e1 ctermfg=DarkBlue
	highlight MBEGlsl     guifg=#cc3333 ctermfg=DarkRed
	highlight MBEHeader   guifg=#7ec0ee ctermfg=DarkBlue
	highlight MBEIgnore   guifg=#cdcdcd ctermfg=Gray
	highlight MBEMel      guifg=#9400d3 ctermfg=DarkRed
	highlight MBEPatch    guifg=#9f5f9f ctermfg=DarkGreen
	highlight MBEPython   guifg=#cd7f32 ctermfg=DarkYellow
	highlight MBERst      guifg=#8b795e ctermfg=DarkYellow
	highlight MBEScons    guifg=#006400 ctermfg=DarkGreen
	highlight MBEText     guifg=#5f9f9f ctermfg=DarkGreen
	highlight MBEVim      guifg=#97694f ctermfg=DarkYellow
	highlight MBERib      guifg=#dd2255 ctermfg=Red
endfunction
call DefineMBEHighlights()

function! MiniBufExplToggleDirectory()
	if g:miniBufExplModifyFileName == ":t"
		let g:miniBufExplModifyFileName = ":."
		let g:miniBufExplGroupDirectories = 1
	else
		let g:miniBufExplModifyFileName = ":t"
		let g:miniBufExplGroupDirectories = 0
	endif

	UMiniBufExplorer
endfunction

let g:miniBufExplModifyFileName = ":."
let g:miniBufExplGroupDirectories = 1
let g:miniBufExplDirSubs = [
			\'|^\(/hosts/croxton\)\{0,1\}/user_data/code|$CODE|',
			\'|^\(/hosts/croxton\)\{0,1\}/user_data|$USER|',
			\'|^/u/dv/code|$CODE|',
			\'|^/u/dv|~|',
			\'|\<trunk\>|$T|',
			\'|\<houdini\>|$H|',
			\]

function! MiniBufExplToggleOrientation()
	CMiniBufExplorer

	if g:miniBufExplVSplit > 0
		let g:miniBufExplVSplit_saved = g:miniBufExplVSplit
		let g:miniBufExplVSplit = 0
	else
		if exists('g:miniBufExplVSplit_saved')
			let g:miniBufExplVSplit = g:miniBufExplVSplit_saved
		else
			let g:miniBufExplVSplit = 30
		endif
	endif

	TMiniBufExplorer
endfunction

noremap <S-F6> :call MiniBufExplToggleOrientation()<CR>
noremap <C-F7> :SMiniBufExplorer<CR>
noremap <F7> :call MiniBufExplToggleDirectory()<CR>
noremap <C-F8> :TMiniBufExplorer<CR>
noremap <S-F8> :UMiniBufExplorer<CR>
