set nocompatible

so ~/.vim/plugins.vim

" Core {{{

set hidden
set nobackup
set nowritebackup
set noswapfile
set noerrorbells
set mouse=a
set number
set relativenumber
set signcolumn=yes

" Use block cursor in insert mode
set guicursor=

" Title
set title
set titlestring=%t%(\ %m%)\ -\ %{has('nvim')?'Neovim':'Vim'}

" Statusline
set noshowmode
set laststatus=2

" Search
set smartcase
set hlsearch

if executable('rg')
  " Use ripgrep over grep
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif

" Panes
set splitbelow
set splitright

" Completion menu
set completeopt-=noselect
set shortmess+=c

" Set max scroll offset (vertically centre cursor within window)
set so=999

" Indents
set shiftwidth=4
set tabstop=4
set expandtab
set linebreak
set breakindent
set nostartofline

" Enable syntax folding
set foldmethod=marker foldlevel=0

"}}}

" File types {{{

autocmd BufRead,BufNewFile *.fish set filetype=fish
autocmd BufNewFile,BufRead *.flow set filetype=javascript
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile Podfile,*.podspec set filetype=ruby
autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact

autocmd FileType gitcommit setlocal spell

"}}}

" Bindings {{{

nmap q <Nop>

map <F6> :setlocal spell!<CR>

if has('mac')
  " Go to URL/path under cursor in default app
  nmap gx :silent execute "!open " . shellescape("<cWORD>")<CR>
endif

" Automatically create parent dirs when writing a file
autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

" Automatically exit if only remaining window is NERDTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" goyo
map <F12> :Goyo<CR>

" fzf
nmap <silent>; :Files<CR>

" NERDTree
nnoremap <Leader>r :NERDTreeFind<CR>
nnoremap <Leader>R :NERDTreeToggle<CR>
nnoremap <Leader>fm :NERDTreeFind<CR>:call NERDTreeMoveNode()<CR>
nnoremap <Leader>fn :NERDTreeFind<CR>:call NERDTreeAddNode()<CR>
nnoremap <Leader>fc :NERDTreeFind<CR>:call NERDTreeCopyNode()<CR>
nnoremap <Leader>fd :NERDTreeFind<CR>:call NERDTreeDeleteNode()<CR>

" vim-workspace
nnoremap <Leader>w :ToggleWorkspace<CR>


"}}}

" Syntax theme {{{

if exists("&termguicolors")
  syntax enable
  set termguicolors

  let g:gruvbox_vert_split = 'bg1'
  let g:gruvbox_sign_column = 'bg0'
  colorscheme gruvbox

  hi Normal guibg=NONE ctermbg=NONE
  hi CursorLineNr ctermfg=white
  hi SignColumn guibg=NONE ctermbg=NONE
  hi clear SpellBad
  hi SpellBad cterm=underline ctermfg=darkred

  hi GitGutterAdd ctermfg=green ctermbg=NONE
  hi GitGutterChange ctermfg=yellow ctermbg=NONE
  hi GitGutterDelete ctermfg=darkred ctermbg=NONE
  hi GitGutterChangeDelete ctermfg=yellow ctermbg=NONE
endif

"}}}

" Plugin options {{{

let g:lightline = {
  \   'active': {
  \     'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \     'right': [['lineinfo'], ['percent'], ['fileformat']]
  \   },
  \ }

let g:workspace_autosave = 0
let g:workspace_session_disable_on_args = 1
let g:workspace_undodir = $HOME . '/.vim/undo'

let g:ctrlsf_default_root = 'project'
let g:ctrlsf_extra_root_markers = ['Session.vim']
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_ignore_dir = ['.git', 'node_modules', 'deps', 'tmp', 'log']
if executable('rg')
  let g:ctrlsf_ackprg = 'rg'
  let g:ctrlsf_extra_backend_args = {
    \   'rg': '--hidden --no-ignore'
    \ }
endif

let g:blamer_enabled = 1
let g:blamer_template = '<author> (<committer-time>) • <summary>'

let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1

let g:deoplete#enable_at_startup = 1

let g:lsc_server_commands = {
 \  'javascript': {
 \    'command': 'typescript-language-server --stdio',
 \    'log_level': -1,
 \    'suppress_stderr': v:true,
 \  },
 \  'typescript': {
 \    'command': 'typescript-language-server --stdio',
 \    'log_level': -1,
 \    'suppress_stderr': v:true,
 \  }
 \}
let g:lsc_auto_map = {
 \  'GoToDefinition': 'gd',
 \  'FindReferences': 'gr',
 \  'Rename': 'gR',
 \  'ShowHover': 'K',
 \  'FindCodeActions': 'ga',
 \  'Completion': 'omnifunc',
 \}
let g:lsc_enable_autocomplete = v:true

"}}}
