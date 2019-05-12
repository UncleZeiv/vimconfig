set nocompatible
filetype off

call plug#begin("~/vimfiles/plugged")

" alternate to related file
let g:alternateExtensions_C = "H,h"
Plug 'vim-scripts/a.vim'

" complete snippets
" imap <C-E> <Plug>snipMateNextOrTrigger
" Plug 'vim-scripts/tlib'
" Plug 'vim-scripts/vim-addon-mw-utils'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsSnippetDirectories=["ultisnippets"]
" Plug 'vim-scripts/garbas/vim-snipmate'
" Plug 'SirVer/ultisnips'

" git plugin
" Plug 'vim-scripts/fugitive.vim'

Plug 'vim-scripts/surround.vim'

" syntax check plugin
Plug 'scrooloose/syntastic'

" file search plugin
let g:ctrlp_extensions = ['mixed']
let g:ctrlp_custom_ignore = '*/.git/*,*/.hg/*,*/.svn/*'
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
Plug 'vim-scripts/ctrlp.vim'

" pretty statusline
if has("gui_running")
	if has("win32")
		let g:Powerline_symbols='fancy'
	else
		let g:Powerline_symbols='unicode'
	endif
endif
Plug 'Lokaltog/vim-powerline'

Plug 'mileszs/ack.vim'

" Plug 'vim-scripts/Align'

Plug 'vim-scripts/linediff.vim'
vnoremap <F6> :Linediff<CR>

" Plug 'vim-scripts/ZoomWin'

if ! has("win32")
	" let g:ycm_filetype_blacklist = {'notes': 1, 'markdown': 1, 'text': 1}
	let g:ycm_confirm_extra_conf = 0
	let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
	Plug 'Valloric/YouCompleteMe'
endif

" Plug 'UncleZeiv/minibufexpl.vim'
" Plug 'kshenoy/vim-signature'

" Plug 'vim-scripts/ingo-library'
" Plug 'vim-scripts/IndentConsistencyCop'
" Plug 'vim-scripts/IndentConsistencyCopAutoCmds'
" Plug 'vim-scripts/vim-multiple-cursors'

" Plug 'tmhedberg/SimpylFold'

" indent options
" set autoindent
" set smartindent
set noexpandtab
set shiftwidth=4
" set smarttab
set tabstop=4
" set cindent
set cinoptions=:0,g0,(1s,

set autoread
set background=dark
set backspace=indent,eol,start
" set completeopt=menu,preview,longest

" ripiglia da qui
if ! has("win32")
	set clipboard+=\\\\|xterm
endif

" set cursorcolumn
set cursorline
set directory=$HOME/vimtmp//
set undodir=$HOME/vimtmp//
set encoding=utf-8
" set foldlevelstart=99
set foldlevel=99
set foldmethod=syntax
set formatoptions=crqw12l "tan
" "n" affects text wrapping in comments, I don't know why
" set formatlistpat=
set guioptions-=T
set hidden
set history=200
set hlsearch
set ignorecase
set include=^\\s*#\\s*include\ \\(<boost/\\)\\@!
set incsearch
set laststatus=2
set linebreak
set mouse=ar
set mousemodel=popup_setpos
set number
set ruler
set scrolloff=10
set showcmd
set showmatch
set smartcase
set splitright
set suffixes-=.h
set suffixesadd+=
" set tabpagemax=50
" set tags=./tags
" set textwidth=79
set undofile
set updatetime=500
set wildignore+=*.o,*.swp,*.pyc,*.so,*.a,*.os
" set wildmenu
" set wildmode=longest:full,full

syntax enable
filetype plugin on
filetype plugin indent on

" search in currently selected visual area
vnoremap g/ /\%V
" search in current {} block
nnoremap g/ [{ms]}me/\%>'s\%<'e<Left><Left><Left><Left><Left>

" go to line number under cursor
" noremap <F2> m':execute "normal " + expand("<cword>") + "G"<CR>
" noremap <F3> :w<CR>:!python2.6 %<CR>
" noremap <F4> :!svn stat<CR>
" noremap <C-F4> ggdG:.!svn diff<CR>:set syntax=diff<CR>
noremap <F9> :set spell!<CR>
noremap <F11> :set list!<CR>
noremap <C-F11> :nohlsearch<CR>
noremap <C-F12> :!ctags --sort=foldcase --recurse --c++-kinds=+p-l --fields=+iaSKn --extra=+q .<CR>

nnoremap <S-PageUp> :tprevious<CR>
nnoremap <S-PageDown> :tnext<CR>
nnoremap <A-PageUp> :ptprevious<CR>
nnoremap <A-PageDown> :ptnext<CR>
" nnoremap <A-]> <C-W>}<CR>

nnoremap f :exe "Ack \"" . expand("<cword>") . "\""<CR>
nnoremap F :exe "Ack -w \"" . expand("<cword>") . "\""<CR>

let g:kerid_defineMappings=1

" close curly braces
" imap {<cr> {<cr>}<esc>kA<cr>

" Minibuffer explorer options
let g:miniBufExplVSplit = 30
let g:miniBufExplorerMoreThanOne = 2
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
" let g:miniBufExplMapCTabSwitchWindows = 1
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplModSelTarget = 1
" let g:miniBufExplMinSize = 30
let g:miniBufExplMaxSize = 40
" let g:miniBufExplForceSyntaxEnable = 1
let g:miniBufExplorerDebugMode = 0

" TODO: missing glsl filetype
autocmd BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setfiletype glsl

" special settings for windows
if has("win32")
	" maximise on entry
	autocmd GUIEnter * simalt ~x "maximize

	" cd to home, when run from start it would otherwise default to the Vim 
	" install directory...
	cd ~
else
	autocmd GUIEnter * call system('wmctrl -i -b add,maximized_vert,maximized_horz -r '.v:windowid)
endif
