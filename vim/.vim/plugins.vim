" Install and run vim-plug on first run
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'beloglazov/vim-textobj-quotes'
Plug 'christoomey/vim-system-copy'
Plug 'dag/vim-fish'
Plug 'darfink/vim-plist'
Plug 'dyng/ctrlsf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'itchyny/lightline.vim'
Plug 'jreybert/vimagit'
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'kana/vim-textobj-user'
Plug 'mattn/emmet-vim'
Plug 'morhetz/gruvbox'
Plug 'pangloss/vim-javascript'
Plug 'reedes/vim-colors-pencil'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'thaerkh/vim-workspace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-shell'

if has('nvim')
    Plug 'APZelos/blamer.nvim'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
endif

call plug#end()
