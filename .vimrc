" Auto-installs vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'kaicataldo/material.vim'
Plug 'benmills/vimux'
call plug#end()

" Dark
"let g:material_terminal_italics = 1
"let g:lightline = { 'colorscheme': 'material_vim' }
"colorscheme material

set laststatus=2
