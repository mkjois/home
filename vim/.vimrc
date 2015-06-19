set tabstop=2
set shiftwidth=2
set expandtab
set smartindent

set number
set columns=85
set numberwidth=5

set comments=sl:/**,mb:\ *,elx:\ */
set formatoptions+=r
set formatoptions+=o

execute pathogen#infect()
syntax enable
if has('gui_running')
    set background=dark
    colorscheme solarized
    set guifont=Monospace\ 10
endif

autocmd FileType Dockerfile setlocal tabstop=4 shiftwidth=4
autocmd FileType python setlocal tabstop=4 shiftwidth=4
autocmd FileType sh setlocal tabstop=4 shiftwidth=4
autocmd FileType vim setlocal tabstop=4 shiftwidth=4
