" Tabs vs spaces? Spaces or GTFO.
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent

" Seeing line numbers is cool, but adhering to the 80 char rule is challenging!
set number
set columns=85
set numberwidth=5

" Javadoc style comments. Still looking to better my (un)commenting efficiency.
set comments=sl:/**,mb:\ *,elx:\ */
set formatoptions+=r
set formatoptions+=o

" nuke the shit outta the arrow keys and others.
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
map <Insert> <Nop>
map <Delete> <Nop>
map <Backspace> <Nop>
map <Return> <Nop>
map <Space> <Nop>
map! <Up> <Nop>
map! <Down> <Nop>
map! <Left> <Nop>
map! <Right> <Nop>
map! <Insert> <Nop>

" Maps I think are useful or rational.
map j gj
map k gk
map 0 g0
map ^ g^
map $ g$
map - gkg^
map = gjg^
map ( gT
map ) gt
map <Return> <C-Z>
map <Space> :w<Return>
nmap K kJ
nmap X 0D
nmap Y y$
nmap gl m`wb~``
nmap gL m`viw~``
noremap ' `
noremap ` '

" Make the arrow keys bubble lines/words in normal and insert modes.
"nmap <UP> ddkP
"nmap <DOWN> ddp
"nmap <LEFT> daWBPB
"nmap <RIGHT> daWWPB
"imap <UP> ddkP
"imap <DOWN> ddp
"imap <LEFT> <Esc>daWBPBi
"imap <RIGHT> <Esc>daWWPBi

" Pathogen plugins and solarized colorscheme (look these up).
execute pathogen#infect()
syntax enable
if has('gui_running')
    set background=dark
    colorscheme solarized
    set guifont=Monospace\ 10
endif

" Some files are best with 4 spaces per indent.
autocmd FileType Dockerfile setlocal tabstop=4 shiftwidth=4
autocmd FileType go setlocal tabstop=4 shiftwidth=4
autocmd FileType python setlocal tabstop=4 shiftwidth=4
autocmd FileType sh setlocal tabstop=4 shiftwidth=4
autocmd FileType vim setlocal tabstop=4 shiftwidth=4
