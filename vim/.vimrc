so ~/.vim/plugins.vim

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
set wildmenu
set completeopt-=noselect

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

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Panes "

set splitbelow
set splitright

" Filetype associations "

autocmd BufRead,BufNewFile *.fish set ft=fish
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile Podfile,*.podspec set filetype=ruby

autocmd FileType gitcommit setlocal spell

" Bindings "

set backspace=indent,eol,start

map <F6> :setlocal spell!<CR>
map <F12> :Goyo<CR>

nmap q <Nop>
nmap <silent>; :Files<CR>
nmap <silent>gx :Open<CR>

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

    " Open actions menu (coc-actions)
    nmap <silent> <leader>a :CocCommand actions.open<cr>
endif

" Automatically create parent dirs when writing a file
autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

" Automatically exit if only remaining window is NERDTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Plugin options "

let g:gruvbox_vert_split = 'bg1'
let g:gruvbox_sign_column = 'bg0'

colorscheme gruvbox

hi Normal guibg=NONE ctermbg=NONE
hi CursorLineNr ctermfg=white
hi SignColumn guibg=NONE ctermbg=NONE

hi clear SpellBad
hi SpellBad cterm=underline ctermfg=darkred

hi ALEErrorSign ctermbg=NONE
hi ALEWarningSign ctermbg=NONE

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

let g:ctrlsf_default_root = 'project'
let g:ctrlsf_extra_root_markers = ['Session.vim']
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_extra_backend_args = {
  \   'ag': '--hidden --ignore .git --ignore node_modules'
  \ }

let g:blamer_enabled = 1
let g:blamer_template = '<committer> (<committer-time>) • <summary>'

let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_preview_window = ''

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
