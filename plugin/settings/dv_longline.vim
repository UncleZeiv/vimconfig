" flag characters beyond column 79
function! ToggleLongLineWarning()
	if ! exists('w:longLineWarning') || w:longLineWarning == 0
		let w:longLineWarning = matchadd('ErrorMsg', '\%>79v.\+', 10)
		set colorcolumn=80
	else
		call matchdelete(w:longLineWarning)
		let w:longLineWarning = 0
		set colorcolumn&
	endif
endfunction

noremap <S-F12> :call ToggleLongLineWarning()<CR>
