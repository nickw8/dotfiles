" VIMRC
" author: Nick Weight

" Vim-Plug {{{
" Auto-installs vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug automatically executes filetype plugin indent on and syntax enable.

call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'benmills/vimux'
call plug#end()
"}}}

" Misc {{{
set laststatus=2
set modelines=1
set nocompatible 
set mouse=a                   " allows for mouse scroll and selection
"if has('mac')       " osx
"  set guifont=...
" else                " linux, bsd, etc
"  set guifont=...
"endif
set clipboard=unnamed         " puts yanked stuff into system clipboard
" }}}

" Tabs and Spaces {{{
set tabstop=2                 " number of visual spaces per TAB
set softtabstop=2             " number of spaces in tab when editing
set expandtab                 " tabs are spaces
" }}}

" UI Config {{{
set number                    " Show current line number
set relativenumber            " Show relative line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" }}}

" Searching {{{
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set path+=**

"Tag Jumping:
command! MakeTags !ctags -R .

" Usage:
" - Use ^] to jump to tag under cursor (includes external files)
" - Use g^] for ambiguous tags (similiar tags in different file types)
" - Use ^t to jump back up the tag stack

"}}}

" vim:foldmethod=marker:foldlevel=0
