" TODO: add <leader 1> to <leader 0> to switch tabs.
let mapleader = ' '
let maplocalleader = '\'

noremap <F2> :Vista!!<CR>

noremap <localleader>y "+y
noremap <localleader>p "+p

" EasyAlign {{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}

let g:which_key_run_map_on_popup = 1
let g:which_key_use_floating_win = 1

set timeoutlen=500
let g:leader_key_map   = {
  \ 'a':     '<Plug>(coc-codeaction-selected)',
  \ 's':    ['StripWhitespace', 'strip-whitespace'],
  \ }
let g:leader_key_map.c = { 'name': '+nerdcommenter' }
let g:leader_key_map.g = {
  \ 'name': '+utilities',
  \ 'a':    ['LiveEasyAlign',  'live-align'],
  \ 'c':    ['ColorToggle',    'highlight-colors'],
  \ 's':    ['Sleuth',         'detect-indent'],
  \ 'u':    ['UndotreeToggle', 'undo-tree'],
  \ }
let g:leader_key_map.h = {
  \ 'name': '+gitgutter',
  \ 'p':    'preview-hunk',
  \ 's':    'stage-hunk',
  \ 'u':    'undo-hunk',
  \}
let g:leader_key_map.l = { 'name': '+coclist' }
let g:leader_key_map.w = {
  \ 'name': '+windows',
  \ 'w':    ['<c-w>w',    'other-window']          ,
  \ 'd':    ['<c-w>c',    'delete-window']         ,
  \ '-':    ['<c-w>s',    'split-window-below']    ,
  \ '|':    ['<c-w>v',    'split-window-right']    ,
  \ '2':    ['<c-w>v',    'layout-double-columns'] ,
  \ 'h':    ['<c-w>h',    'window-left']           ,
  \ 'j':    ['<c-w>j',    'window-below']          ,
  \ 'l':    ['<c-w>l',    'window-right']          ,
  \ 'k':    ['<c-w>k',    'window-up']             ,
  \ 'H':    ['<c-w>5<',   'expand-window-left']    ,
  \ 'J':    ['resize +5', 'expand-window-below']   ,
  \ 'L':    ['<c-w>5>',   'expand-window-right']   ,
  \ 'K':    ['resize -5', 'expand-window-up']      ,
  \ '=':    ['<c-w>=',    'balance-window']        ,
  \ 's':    ['<c-w>s',    'split-window-below']    ,
  \ 'v':    ['<c-w>v',    'split-window-below']    ,
  \ '?':    ['windows',   'fzf-window']            ,
  \ }
let g:leader_key_map.z = {
  \ 'name': '+zen-mode',
  \ 'z':    [':Goyo',        'toggle-zen-mode'],
  \ 'l':    {
  \     'name': '+Limelight',
  \     'l':    [':Limelight',  'turn-on-limelight'],
  \     'k':    [':Limelight!', 'turn-off-limelight'],
  \     }
  \ }

let g:localleader_key_map = {
  \ 'p': 'clipboard-paste',
  \ 'y': 'clipboard-yank',
  \ }
let g:localleader_key_map['\'] = { 'name' : '+Vim-Multi-cursor' }

autocmd FileType tex let g:localleader_key_map.l = { 'name': '+vimtex' }
autocmd FileType markdown let g:localleader_key_map.l = {
  \ 'name': '+markdown',
  \ 'p':    {
  \     'name': '+preview',
  \     'l':    ['MarkdownPreview',     'preview'],
  \     'k':    ['MarkdownPreviewStop', 'stop-preview'],
  \     }
  \ }

nmap <space>e :CocCommand explorer<CR>
