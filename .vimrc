" VIMRC
" author: Nick Weight

" Setup {{{
set nocompatible 
" noremap <Space> <Nop>     " Remove previous space bar behavior as acting like move right
" map <Space> <leader>      " Set Space bar as Leader
let mapleader = "\<Space>"
set backspace=indent,eol,start
" }}}

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
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'       " https://github.com/tpope/vim-surround - cs to wrap, yss to wrap line, ds to remove
Plug 'tpope/vim-commentary'     " https://github.com/tpope/vim-commentary - gcc to comment out a line (takes a count), gc to comment out the target of a motion
" Plug 'easymotion/vim-easymotion.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

"}}}

" Vimux {{{

map <Leader>vp :VimuxPromptCommand<CR>

" }}}

" FZF {{{
nnoremap <C-p> :Files<Cr>
" }}}

" Misc {{{
set laststatus=2
set modelines=1
set mouse=a                   " allows for mouse scroll and selection
set clipboard=unnamed         " puts yanked stuff into system clipboard
" }}}

" Tabs and Spaces {{{
set tabstop=2                 " number of visual spaces per TAB
set softtabstop=2             " number of spaces in tab when editing
set expandtab                 " tabs are spaces
" }}}

" Splits {{{
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <silent> <Leader>\| :vsplit<CR>
nnoremap <silent> <Leader>- :split<CR>

set splitbelow
set splitright
"}}}

" UI Config {{{
set number                    " Show current line number
set relativenumber            " Show relative line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
" turn off search highlight
nnoremap <Leader>c :nohl<CR>  

function! NeatFoldText() "{{{2
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()
" }}}2

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
