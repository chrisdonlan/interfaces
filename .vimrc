syntax on
set keymap=dvorak
set tabstop=2
set shiftwidth=2
set noexpandtab
set softtabstop=2
colorscheme elflord
set autoindent
set foldmethod=syntax


au BufNewFile,BufRead *.cu set ft=cuda
au BufNewFile,BufRead *.cuh set ft=cuda

au BufRead,BufNewFile *.scala set filetype=scala
au! Syntax scala source ~/.vim/syntax/scala.vim
