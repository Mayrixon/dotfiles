" TODO: add <leader 1> to <leader 0> to switch tabs.
let mapleader = ' '
let maplocalleader = '\'

let g:leader_key_map   = {
  \ 'a':  'code-action-selected',
  \ 'ac': 'code-action',
  \ 's':  ['StripWhitespace',         'strip-whitespace'],
  \ }
let g:leader_key_map.g = {
  \ 'name': '+utilities',
  \ 'a':    ['LiveEasyAlign',  'live-align'],
  \ 'c':    ['ColorToggle',    'highlight-colors'],
  \ 'g':    ['Twiggy',         'twiggy'],
  \ 's':    ['Sleuth',         'detect-indent'],
  \ 'u':    ['UndotreeToggle', 'undo-tree'],
  \ }
let g:leader_key_map.t = {
  \ 'name': '+tabs',
  \ 'c':    [':tabc',     'close-tab'],
  \ 'e':    [':tabe',     'new-tab'],
  \ 'g':    [':tabe|:G',  'fugitive'],
  \ 'G':    [':tabe|:GV', 'git-log'],
  \ 'n':    [':tabn',     'next-tab'],
  \ 'p':    [':tabp',     'previous-tab'],
  \ }
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
  \ }

let g:localleader_key_map = {
  \ 'p': ['\"+p', 'clipboard-paste'],
  \ 'y': ['\"+y', 'clipboard-yank'],
  \ }
let g:localleader_key_map['\'] = { 'name' : '+Vim-Multi-cursor' }

call which_key#register('<Space>', "g:leader_key_map")
call which_key#register('\', "g:localleader_key_map")

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  '\'<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual  '\'<CR>
