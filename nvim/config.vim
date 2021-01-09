let g:rainbow_active = 1
let g:rainbow_conf = {
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\}

let g:better_whitespace_ctermcolor = 'DarkGray'
let g:better_whitespace_guicolor = 'DarkGray'

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

" NERDCommenter {{{
let g:NERDSpaceDelims = 1
" }}}

" indentLine {{{
" let g:indentLine_fileTypeExclude = ['tex', 'markdown']
let g:indentLine_setConceal = 0
" autocmd FileType tex setlocal conceallevel=0
" autocmd FileType markdown setlocal conceallevel=0
" }}}

let g:tex_flavor = 'latex'
" }}}

set background=dark
let g:gruvbox_italic = 1
colorscheme gruvbox

set signcolumn=yes

" set colorcolumn=80
set shortmess+=c
set updatetime=300

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set wrapscan               " Searches wrap around end-of-file.
set synmaxcol   =200       " Only highlight the first 200 columns.

set list                   " Show non-printable characters.

" lightline {{{
set noshowmode
set showtabline=2

let g:bufferline_echo = 0
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''

augroup lightline
  autocmd!
  autocmd Filetype * :call lightline#update()
augroup END

function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
  \ 'colorscheme': 'gruvbox',
		\ 'separator': { 'left': '', 'right': '' },
		\ 'subseparator': { 'left': '', 'right': '' },
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified', ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype', 'sw' ]],
  \ },
  \ 'tabline': {
  \   'left': [ [ 'tabs' ] ],
  \   'right': [ [ 'relativepath' ] ],
  \ },
  \ 'component': {
  \   'filename': '%n:%t',
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status',
  \   'currentfunction': 'CocCurrentFunction',
  \   'filepath': 'LightlineAbsoluteFilePath',
  \   'gitbranch': 'fugitive#head',
  \   'sw': 'SleuthIndicator',
  \ },
  \ }
" }}}

" mkdx {{{
let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
			\ 'enter': { 'shift': 1 },
			\ 'links': { 'external': { 'enable': 1 } },
			\ 'map': { 'prefix': '<localleader>l', 'enable': 1 },
			\ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
			\ 'fold': { 'enable': 1 } }
" }}}

" NERDCommenter {{{
let g:NERDSpaceDelims = 1
" }}}

" vimtex {{{
let g:vimtex_format_enabled=1
let g:vimtex_fold_enabled=1
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

if has('mac')
  let g:vimtex_view_method='skim'
else
  let g:vimtex_view_method='zathura'
endif
" }}}

" vim-gutentags {{{
" Stop recursive searching when found following folders
let g:gutentags_enabled = 0
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project', '.vim']

let g:gutentags_ctags_tagfile = '.tags'

let g:gutentags_modules = []
if executable('ctags')
  let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
  let g:gutentags_modules += ['gtags_cscope']
endif

" Save tag files in the folder ~/.cache/tags
let g:gutentags_cache_dir = expand('~/.cache/tags')

" Exuberant-ctags cannot have --extra=+q.
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" Universal ctags requires the following setting.
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

let g:gutentags_auto_add_gtags_cscope = 0
" }}}

" vim-visual-multi {{{
let g:VM_mouse_mappings = 1
" }}}

" Vista {{{
let g:vista_sidebar_position = 'vertical botright'
let g:vista_default_executive = 'coc'
let g:vista_echo_cursor_strategy = 'floating_win'
" }}}


" limelight {{{
" " Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
" let g:limelight_priority = -1
" }}}

" goyo.vim {{{
function! s:goyo_enter()
  if has('gui_running')
    set fullscreen
    set background=light
    set linespace=7
  endif
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999

  set lbr
  map j gj
  map k gk

  Limelight
endfunction

function! s:goyo_leave()
  if has('gui_running')
    set nofullscreen
    set background=dark
    set linespace=0
  endif
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=1

  set nolbr
  unmap j
  unmap k

  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" }}}

" === UndoTree
" using relative positioning instead
let g:undotree_CustomUndotreeCmd = 'vertical 32 new'
let g:undotree_CustomDiffpanelCmd= 'belowright 12 new'

" === Goyo
" changing from the default 80 to accomodate for UndoTree panel
let g:goyo_width = 104
