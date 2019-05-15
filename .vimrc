" some ideas:
"   https://gist.github.com/NickLaMuro/1147370
"   http://talks.nicklamuro.com/vim_tmux#vim-my-vimrc


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
