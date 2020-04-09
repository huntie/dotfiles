" GVim-specific settings "

" Configure for distraction-free prose editing "

set laststatus=0
set background=light
set guioptions=
set guioptions-=T
set guifont=Native:h14

colorscheme pencil

let g:better_whitespace_enabled=0

autocmd VimEnter * Goyo
