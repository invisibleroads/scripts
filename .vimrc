set ts=4
set sw=4
set sta
set sr
set et
set ai
set hls
set is
filetype plugin on
filetype indent on
syn on
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_ViewRule_dvi='xdvi'
autocmd FileType python compiler pylint
let g:pylint_onwrite = 0
let g:pylint_show_rate = 0
au BufRead,BufNewFile *.py_tmpl setfiletype python
au BufRead,BufNewFile *.mako setfiletype html
au BufRead,BufNewFile *.mako_tmpl setfiletype html
