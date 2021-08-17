set nocompatible
set number
set encoding=utf-8
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-unimpaired'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-abolish'
Plugin 'ervandew/supertab'
Plugin 'easymotion/vim-easymotion'
Plugin 'tommcdo/vim-exchange'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'tpope/vim-repeat'
Plugin 'powerline/powerline'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'tpope/vim-vinegar'
Plugin 'bronson/vim-visual-star-search'
Plugin 'vimwiki/vimwiki'
Plugin 'Raimondi/delimitMate'
Plugin 'ldong/vim_loremipsum'
"html edit
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'WolfgangMehner/bash-support'
Plugin 'godlygeek/tabular'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
"size of a hard tabstop
set tabstop=8
"visual mode search
vnoremap // y/<C-R>"<CR>
let mapleader = "\<Space>"

if has('clipboard')
    " copy & paste to system clipboard
    vmap <Leader>y "+y
    vmap <Leader>d "+d
    nmap <Leader>p "+p
    nmap <Leader>P "+P
    vmap <Leader>p "+p
    vmap <Leader>P "+P
else
    " vim does not support xtremclip board and use temp fie instead
    echo 'clipboard not available'
    vnoremap <leader>y :w! /tmp/vitmp<CR>
    nnoremap <leader>p :r! cat /tmp/vitmp<CR>
endif

" size of an "indent"
set shiftwidth=4
set ignorecase
set smartcase
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a
set incsearch
set hls
" set shell=powershell
"set shellcmdflag=-command
set foldmethod=indent
match errorMsg /[^\t]\zs\t\+/
:highlight CursorLine guibg=lightblue ctermbg=lightgray
" nnoremap <c-j> /<+.\{-1,}+><cr>c/+>/e<cr>
" inoremap <c-j> <ESC>/<+.\{-1,}+><cr>c/+>/e<cr>
match Todo /<+.\++>/
iabbrev <buffer> forlp for (!cursor!;<+++>;<+++>){<cr><+++><cr>}<Esc>:call search('!cursor!','b')<cr>cf!

set rnu
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>
:inoremap jk <esc>
:inoremap kj <esc>
set wildignore+=*.a,*.o
set wildignore+=.git,.svn
set wildignore+=*~,*.swp,*tmp

set history=100

set listchars=tab:>~,nbsp:_,trail:.
set list

nnoremap ; :
nnoremap : ;




"vsplit the previous buffer
nnoremap <leader>s :execute "rightbelow vsplit " . bufname("#")<cr>
nnoremap <leader>c :<c-u>execute "normal! mqA;\<esc>`q"<cr>

"quickfix window toggling

set colorcolumn=80
"set spell
"smart indentation
:vnoremap < <gv
:vnoremap > >gv

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Multi-mode mappings (Normal, Visual, Operating-pending modes).
noremap Y y$

" <Leader><Leader> -- Open last buffer.
nnoremap <Leader><Leader> <C-^>
function! ToggleEndChar(charToMatch)
    s/\v(.)$/\=submatch(1)==a:charToMatch ? '' : submatch(1).a:charToMatch
endfunction
nnoremap ;; :call ToggleEndChar(';')<CR>
nnoremap ,, :call ToggleEndChar(',')<CR>

inoremap II <Esc>I
inoremap AA <Esc>A
inoremap OO <Esc>O
inoremap CC <Esc>C
" inoremap SS <Esc>S
inoremap DD <Esc>dd
inoremap UU <Esc>u

colorscheme zmrok
" colorscheme ChocolateLiquor
:nnoremap <leader>t :NERDTreeToggle<CR>
let g:session_autoload = 'no'
let g:session_autosave = 'no'
set hidden
