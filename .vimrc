call plug#begin()
Plug 'dense-analysis/ale'
" Plug 'will133/vim-dirdiff'
call plug#end()

let g:ale_linters = {'python': ['ruff']}
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['ruff', 'ruff_format']}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_echo_msg_format = '%linter% %code% %s'
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

filetype plugin indent on
syntax on
colorscheme torte
set autochdir

set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab shiftround autoindent
set hlsearch incsearch

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-e> <c-w>

nnoremap <Leader>[ :tabprevious<CR>
nnoremap <Leader>] :tabnext<CR>

augroup invisibleroads_scripts
    autocmd!
    autocmd BufNewFile,BufRead *.md setfiletype markdown
    autocmd BufNewFile,BufRead *.json,*.geojson setfiletype json
    autocmd FileType html,htmldjango,xhtml,css,javascript,json,sh,terraform,terraform-vars,typescript,typescriptreact,yaml,nginx
        \ setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd BufNewFile,BufRead *hierarchy.txt,*.goals setfiletype hierarchy
    autocmd FileType hierarchy
        \ setlocal smartindent foldmethod=expr foldtext=getline(v:foldstart) fillchars=fold:\
        \ foldexpr=(getline(v:lnum)=~'^$')?'=':((indent(v:lnum)<indent(v:lnum+1))?'>'.(indent(v:lnum+1)/&l:shiftwidth):indent(v:lnum)/&l:shiftwidth)
augroup END

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
nnoremap <Leader>w :call TrimWhitespace()<CR>
