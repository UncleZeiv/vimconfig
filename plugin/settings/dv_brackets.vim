function! TightBrackets()
	silent! '<,'>s/\([([{]\)\s\+/\1/g
	silent! '<,'>s/\s\+\([)\]}]\)/\1/g
endfunction

function! LooseBrackets()
	silent! '<,'>s/\([([{]\)\s*/\1 /g
	silent! '<,'>s/\s*\([)\]}]\)/ \1/g
endfunction

vnoremap ,bl :call LooseBrackets()<CR>
vnoremap ,bt :call TightBrackets()<CR>

" blah [bar {baz foo(bar)
