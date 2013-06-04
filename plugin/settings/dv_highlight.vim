
" highlight NonText term=standout ctermbg=yellow guibg=yellow
function! SpecialKeyHighlight()
	highlight SpecialKey term=standout ctermbg=yellow guibg=yellow
endfunction
call SpecialKeyHighlight()
set listchars=eol:$,tab:>-,trail:.,extends:>,precedes:<,nbsp:_

function! SameVarHighlight()
	highlight SameVar term=standout ctermbg=LightBlue guibg=LightBlue
endfunction
call SameVarHighlight()

let g:matchCursorWordId = 42

function MatchCursorWord()
	silent! call matchdelete(g:matchCursorWordId)
	if ! exists('w:matchCursorWord') || w:matchCursorWord == 0
		if match(getline('.')[col('.') - 1], '\s') != 0
			call matchadd('SameVar', printf('\V\<%s\>', expand('<cword>')), 10, g:matchCursorWordId)
		endif
	endif
endfunction

" autocmd CursorMoved * silent! exe printf('2match SameVar /\V\<%s\>/', expand('<cword>'))
autocmd CursorMoved * silent! call MatchCursorWord()
