let g:loaded_python_provider = 0
let g:python3_host_prog = '/usr/bin/python3'

set undofile

set foldmethod=syntax
" set nofoldenable

" Original ~/.vimrc {{{
set number
set relativenumber

set mouse=a

set hidden                 " Switch between buffers without having to save first.

set ignorecase
set smartcase

set cursorline             " Find the current line quickly.

set list                   " Show non-printable characters.

set conceallevel=1
set concealcursor=nc

set signcolumn=yes

" set colorcolumn=80
set shortmess+=c
set updatetime=300

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set wrapscan               " Searches wrap around end-of-file.
set synmaxcol   =200       " Only highlight the first 200 columns.

set list                   " Show non-printable characters.
