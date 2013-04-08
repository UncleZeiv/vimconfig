function! GitLog(branchPoint)
	if a:branchPoint != ''
		let l:branchPoint = a:branchPoint
	else
		let l:branchPoint = 'remotes/trunk'
	endif
	exec '.!git log --format=format:"* \%B" '.l:branchPoint.'..'
endfunction

command! -nargs=? GitLog call GitLog('<args>')
