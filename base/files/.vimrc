""""""""""""""""""
" Terminal vimrc "
""""""""""""""""""

source ~/.basevimrc

" Line numbers and the like
set number
set numberwidth=5
set nowrap
set laststatus=2
set statusline=%#Special#\ %m%r\ %#PreProc#%f%=%#Identifier#L%l/%L\ C%c\ B%o\ %#Statement#%{&ft}\ %{&fenc?&fenc:&enc}\ %{&ff}

" Javadoc style comments. Still looking to better my (un)commenting efficiency
set comments=sl:/**,mb:\ *,elx:\ */
set formatoptions+=r
set formatoptions+=o

" Pathogen plugins (see ~/.vim/bundle/)
execute pathogen#infect()
syntax enable
