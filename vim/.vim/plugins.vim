" Install and run vim-plug on first run
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has('nvim')
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'christoomey/vim-system-copy'
Plug 'cohama/lexima.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'mattn/emmet-vim'
Plug 'rrethy/vim-illuminate'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'thaerkh/vim-workspace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'

" Text objects
Plug 'kana/vim-textobj-user'
Plug 'beloglazov/vim-textobj-quotes'

" Filetype specific
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'darfink/vim-plist', { 'for': 'plist' }
Plug 'HerringtonDarkholme/yats.vim', { 'for': 'typescript' }
Plug 'jparise/vim-graphql', { 'for': 'graphql' }

if has('nvim')
    Plug 'APZelos/blamer.nvim'
    Plug 'natebosch/vim-lsc'
endif

call plug#end()
