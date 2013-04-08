let g:is_work = $DN_SITE != ''

if g:is_work
	" work related: use this to avoid tcsh startup
	set shell=sh
endif

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" alternate to related file
Bundle 'a.vim'

" complete snippets
Bundle 'tlib'
Bundle 'vim-addon-mw-utils'
Bundle 'garbas/vim-snipmate'

" git plugin
Bundle 'fugitive.vim'

Bundle 'surround.vim'

" syntax check plugin
" Bundle 'Syntastic'

" file search plugin
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_working_path_mode = 0
Bundle 'ctrlp.vim'

" pretty statusline
if has("gui_running")
	let g:Powerline_symbols='unicode'
endif
Bundle 'Lokaltog/vim-powerline'

Bundle 'mileszs/ack.vim'

Bundle 'Align'

Bundle 'linediff.vim'

" Bundle 'UncleZeiv/minibufexpl.vim'

" indent options
" set autoindent
" set smartindent
set noexpandtab
set shiftwidth=4
set smarttab
set tabstop=4
" set cindent
set cinoptions=:0,g0,(1s,

set autoread
set background=dark
set backspace=indent,eol,start
" set completeopt=menu,preview,longest

" ripiglia da qui
"
set clipboard+=\\\\|xterm

" set cursorcolumn
set cursorline
set directory=/user_data/.tmp//
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
set path=.,..,/usr/include/,/tools/SITE/rnd/include,/tools/SITE/include,,
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
set tags+=/
set tags+=~/.ctags.d/cpp
set tags+=~/.ctags.d/gl
set tags+=~/.ctags.d/maya2011
set tags+=~/.ctags.d/dneg
set tags+=~/.ctags.d/dnex
" set textwidth=79
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*  " Linux/MacOSX
set wildignore+=*.o,*.swp,*.pyc,*.so,*.a,*.os
" set wildmenu
" set wildmode=longest:full,full

syntax enable
filetype plugin on
filetype plugin indent on

let g:ctrlp_extensions = ['buffertag', 'tag', 'changes', 'mixed']

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
imap {<cr> {<cr>}<esc>kA<cr>

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

vnoremap <F6> :Linediff<CR>
