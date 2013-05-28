
let g:pyindent_open_paren = '&sw'
" let g:pyindent_nested_paren = '&sw'
" let g:pyindent_continue = '&sw * 2'

" instead of 2x
let g:pyindent_continue = '&sw'

" indent finder (script 513)
" if ! has("win32")
" 	augroup IndentFinder
" 		au! IndentFinder
" 		au BufRead *.* let b:indent_finder_result = system('python -c "import indent_finder; indent_finder.main()" --vim-output "' . expand('%') . '"' )
" 		au BufRead *.* execute b:indent_finder_result
" 	augroup End
" endif
