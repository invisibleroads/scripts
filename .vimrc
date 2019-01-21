set nocompatible

" Install plugins with vundle
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Plugin 'scrooloose/syntastic'
    " set statusline+=%#warningmsg#
    " set statusline+=%{SyntasticStatuslineFlag()}
    " set statusline+=%*
    " let g:syntastic_auto_loc_list=1
    " let g:syntastic_check_on_wq=0
    " let g:syntastic_loc_list_height=3
Plugin 'w0rp/ale'
Plugin 'bling/vim-airline'
Plugin 'Raimondi/delimitMate'
Plugin 'will133/vim-dirdiff'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

call vundle#end()
filetype plugin indent on
syntax on

" Customize file handling
autocmd BufRead,BufNewFile *.md set filetype=ghmarkdown
autocmd BufRead,BufNewFile *.json set filetype=json
autocmd BufRead,BufNewFile *.py_tmpl set filetype=python
autocmd BufRead,BufNewFile *.mako,*.mako_tmpl,*.jinja2 set filetype=html
autocmd! FileType html,xhtml,sass,scss,css,javascript,json,yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd! FileType ghmarkdown,nginx setlocal tabstop=4 shiftwidth=4 softtabstop=4

" Strip trailing whitespace
fun! <SID>StripTrailingWhitespace()
    let l = line('.')
    let c = col('.')
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre *.md :call <SID>StripTrailingWhitespace()

" Define hierarchical folds for goals
autocmd BufRead,BufNewFile *.goals set filetype=goals
autocmd! FileType goals setlocal smartindent foldmethod=expr foldexpr=(getline(v:lnum)=~'^$')?'=':((indent(v:lnum)<indent(v:lnum+1))?'>'.(indent(v:lnum+1)/&l:shiftwidth):indent(v:lnum)/&l:shiftwidth) foldtext=getline(v:foldstart) fillchars=fold:\ "

" Define indent behavior
set tabstop=4      " Convert existing tabs to 4 spaces
set shiftwidth=4   " Use >> and << to shift indent by 4 columns
set softtabstop=4  " Insert/delete 4 spaces with TAB/BACKSPACE
set expandtab      " Insert spaces when hitting TAB
set shiftround     " Round indent to multiple of shiftwidth
set autoindent     " Align new line indent with previous line

" Define search behavior
set hlsearch       " Highlight matches
set incsearch      " Search incrementally

" Remap window movement keys
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l

" Remap tab movement keys
map <Leader>[ <esc>:tabprevious<CR>
map <Leader>] <esc>:tabnext<CR>

" Configure miscellaneous settings
set autochdir      " Change directory to the folder containing the current file
