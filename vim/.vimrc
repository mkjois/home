" Tabs vs spaces? Spaces or GTFO.
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent

" Seeing line numbers is cool, but adhering to the 80 char rule is challenging!
set number
set numberwidth=5
set nowrap

" Javadoc style comments. Still looking to better my (un)commenting efficiency.
set comments=sl:/**,mb:\ *,elx:\ */
set formatoptions+=r
set formatoptions+=o

" Splits
set splitright
set splitbelow

" nuke the shit outta the arrow keys and others.
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Insert> <Nop>
noremap <Delete> <Nop>
noremap <Backspace> <Nop>
noremap <Return> <Nop>
noremap <Space> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
noremap! <Insert> <Nop>

" Maps I think are useful or rational.
noremap j gj
noremap k gk
noremap 0 g0
noremap ^ g^
noremap $ g$
noremap - gkg^
noremap = gjg^
noremap ( gT
noremap ) gt
noremap [ <C-W>h
noremap ] <C-W>l
noremap <Return> <C-Z>
noremap <Space> :w<Return>
nnoremap K gkJ
nnoremap X 0D
nnoremap Y y$
noremap ' `
noremap ` '
noremap! <S-CR> <Esc>

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
autocmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab
autocmd FileType python setlocal tabstop=4 shiftwidth=4
autocmd FileType sh setlocal tabstop=4 shiftwidth=4
autocmd FileType vim setlocal tabstop=4 shiftwidth=4

" Make goimports the gofmt command
let g:go_fmt_command = "goimports"
