set tabstop=2
set shiftwidth=2
set expandtab
set smartindent

set number
set columns=80
set numberwidth=5

set comments=sl:/**,mb:\ *,elx:\ */
set formatoptions+=r
set formatoptions+=o

execute pathogen#infect()
syntax enable
if has('gui_running')
    set background=dark
    colorscheme solarized
    set guifont=Monospace\ 12
endif

autocmd FileType python setlocal tabstop=4 shiftwidth=4
