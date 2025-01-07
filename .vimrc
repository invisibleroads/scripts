call plug#begin()

Plug 'dense-analysis/ale'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['yapf'],
\}
let g:ale_linters_ignore = {
\   'python': ['mypy'],
\}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_echo_msg_format = '%linter% %s'
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>
Plug 'bling/vim-airline'
Plug 'andymass/vim-matchup'
Plug 'will133/vim-dirdiff'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'

call plug#end()

filetype plugin indent on
syntax on

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

" Define backup window key for browser shells
noremap <c-e> <c-w>

" Remap tab movement keys
map <Leader>[ <esc>:tabprevious<CR>
map <Leader>] <esc>:tabnext<CR>

" Configure miscellaneous settings
set autochdir      " Change directory to the folder containing the current file

" Configure filetype settings
augroup invisibleroads_scripts
    autocmd!
    autocmd BufRead,BufNewFile *.md set filetype=ghmarkdown
    autocmd BufRead,BufNewFile *.json,*.geojson set filetype=json
    autocmd! FileType html,htmldjango,xhtml,css,javascript,json,terraform,terraform-vars,typescript,typescriptreact,yaml,nginx setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd! FileType ghmarkdown setlocal tabstop=4 shiftwidth=4 softtabstop=4
    " Define hierarchical folds for goals
    autocmd BufRead,BufNewFile *.goals set filetype=goals
    autocmd! FileType goals setlocal smartindent foldmethod=expr foldexpr=(getline(v:lnum)=~'^$')?'=':((indent(v:lnum)<indent(v:lnum+1))?'>'.(indent(v:lnum+1)/&l:shiftwidth):indent(v:lnum)/&l:shiftwidth) foldtext=getline(v:foldstart) fillchars=fold:\ "
augroup END

" Configure colorscheme
" colorscheme default
colorscheme torte
