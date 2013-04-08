" :T 'x' sets the window title to <server number> <x> if x is present, current 
" buffername otherwise
function! TitleString(customName)
	let l:serverNum = v:servername[4:]
	if l:serverNum == ''
		let l:serverNum = '0'
	endif
	if a:customName != ''
		let l:customName = a:customName
	else
		let l:customName = '%t'
	endif
	exec 'set titlestring='.l:serverNum.'\ '.l:customName
endfunction

command! -nargs=? T call TitleString('<args>')
autocmd VimEnter * call TitleString('')
