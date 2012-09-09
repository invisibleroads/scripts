" Enable syntax highlighting
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on
autocmd BufRead,BufNewFile *.py_tmpl set filetype=python
autocmd BufRead,BufNewFile *.mako set filetype=html
autocmd BufRead,BufNewFile *.mako_tmpl set filetype=html
autocmd! FileType html setlocal tabstop=2 shiftwidth=2
autocmd! FileType python setlocal nonumber
" Define tab behavior
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set shiftround
" Define search behavior
set hlsearch
set incsearch
" Remap window movement keys
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l
" Remap tab movement keys
map <Leader>[ <esc>:tabprevious<CR>
map <Leader>] <esc>:tabnext<CR>
" Set plugin options: ctrlp
set wildignore+=*.pyc
set wildignore+=*_build/*
" Set plugin options: python-mode
let g:pymode_rope_guess_project=0
