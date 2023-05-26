set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" See https://neovim.io/doc/user/vim_diff.html#vim-differences
source ~/.vimrc

if !has('nvim')
    set ttymouse=xterm2
endif

if has('gui_vimr')
    source ~/.config/nvim/ginit.vim
endif
