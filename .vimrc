filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

syntax on

" Turns off background color
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif

packadd! onedark.vim
colorscheme onedark

set backspace=indent,eol,start

" Use OS clipboard
set clipboard=unnamed
" No error bells
set noerrorbells
" Dynamic Search Highlighting
set incsearch
" Mouse
set mouse=a
set autoindent
set number
set copyindent
" Matching braces
set showmatch
" Fast Scroll
set ttyfast
" Encoding
set encoding=utf-8
" Undo History
set undolevels=1000
" Bind jj to Esc
:imap jj <Esc>
