set hidden
set nobackup
set nowritebackup
set noswapfile
set noerrorbells
set autoread
set updatetime=300

set mouse=a

if !has('nvim')
    set ttymouse=xterm2
endif

set so=999
set clipboard=unnamedplus
set wildmenu

if has('mac')
    set clipboard=unnamed
endif

" Appearance "

syntax enable

set number
set relativenumber
set signcolumn=yes
set linespace=12

set title
set titlestring=%F\ -\ vim
set guicursor=
set noshowmode
set laststatus=2
set shortmess+=c

set termguicolors
set background=dark

" File behaviour "

set expandtab
set smarttab
set linebreak
set breakindent
set nostartofline

set shiftwidth=4
set tabstop=4

" Search "

set smartcase
set hlsearch
set incsearch

" Panes "

set splitbelow
set splitright

" Filetype associations "

autocmd BufRead,BufNewFile *.fish set ft=fish
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile Podfile,*.podspec set filetype=ruby

autocmd FileType gitcommit setlocal spell

autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx undojoin | Neoformat

" Bindings "

set backspace=indent,eol,start

map <F6> :setlocal spell!<CR>
map <F12> :Goyo<CR>

nmap q <Nop>
nmap <silent> ; :Files<CR>

nnoremap <Leader>s :%s/
nnoremap <Leader>S :%s/\<<C-r><C-w>\>/
nnoremap <Leader>r :NERDTreeFind<cr>
nnoremap <Leader>R :NERDTreeToggle<cr>
nnoremap <Leader>w :ToggleWorkspace<CR>

nnoremap <Leader>fm :NERDTreeFind<cr>:call NERDTreeMoveNode()<cr>
nnoremap <Leader>fn :NERDTreeFind<cr>:call NERDTreeAddNode()<cr>
nnoremap <Leader>fc :NERDTreeFind<cr>:call NERDTreeCopyNode()<cr>
nnoremap <Leader>fd :NERDTreeFind<cr>:call NERDTreeDeleteNode()<cr>

if &runtimepath =~ 'coc.nvim'
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <silent> grn <Plug>(coc-rename)

    inoremap <silent><expr> <c-space> coc#refresh()

    " Use tab to select completions
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    autocmd CursorHold * silent call CocActionAsync('highlight')
endif

" Automatically create parent dirs when writing a file
autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

" Automatically exit if only remaining window is NERDTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Plugins "

" Install and run vim-plug on first run
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

so ~/.vim/plugins.vim

let g:gruvbox_vert_split = 'bg1'
let g:gruvbox_sign_column = 'bg0'

colorscheme gruvbox

hi Normal ctermbg=NONE
hi CursorLineNr ctermfg=white
hi SignColumn ctermbg=NONE

hi clear SpellBad
hi SpellBad cterm=underline ctermfg=darkred

hi GitGutterAdd ctermfg=green ctermbg=NONE
hi GitGutterChange ctermfg=yellow ctermbg=NONE
hi GitGutterDelete ctermfg=darkred ctermbg=NONE
hi GitGutterChangeDelete ctermfg=yellow ctermbg=NONE

let g:lightline = {
  \     'active': {
  \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \         'right': [['lineinfo'], ['percent'], ['fileformat']]
  \     },
  \ }

let g:workspace_autosave = 0
let g:workspace_session_disable_on_args = 1
let g:workspace_undodir = $HOME . '/.vim/undo'

let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1

let $FZF_DEFAULT_COMMAND = 'ag --hidden --depth=10 --ignore .git -f -g ""'
let $FZF_DEFAULT_OPTS = '' " Disable --preview option set in shell

" Functions supporting coc.nvim

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
