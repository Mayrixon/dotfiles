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

let g:leader_key_map   = {
  \ 'a':  'code-action-selected',
  \ 'ac': 'code-action',
  \ 's':  ['StripWhitespace',         'strip-whitespace'],
  \ }
let g:leader_key_map.c = { 'name': '+nerdcommenter' }
let g:leader_key_map.f = {
  \ 'name': '+fzf',
  \ 'b':    [':Buffers',  'buffers'],
  \ 'c':    [':Commits',  'commits'],
  \ 'C':    [':BCommits', 'buffer-commits'],
  \ 'f':    [':Files',    'files'],
  \ 'ft':   [':Filetypes', 'file-types'],
  \ 'gg':   [':GFiles',   'git-files-ls-files'],
  \ 'g?':   [':GFiles?',  'git-files-status'],
  \ 'hh':   [':History',  'file-history'],
  \ 'h:':   [':History:', 'command-history'],
  \ 'h/':   [':History/', 'search-history'],
  \ 'l':    [':Lines',    'lines-loaded-buffers'],
  \ 'L':    [':Blines',   'lines-current-buffer'],
  \ 'm':    [':Marks',    'Marks'],
  \ 'M':    ['Maps',      'nmaps'],
  \ 'r':    [':Rg',       'ripgrep'],
  \ 't':    [':Tags',     'tags-project'],
  \ 'T':    [':BTags',    'tags-buffer'],
  \ 'w':    [':Windows',  'windows'],
  \ }
let g:leader_key_map.g = {
  \ 'name': '+utilities',
  \ 'a':    ['LiveEasyAlign',  'live-align'],
  \ 'c':    ['ColorToggle',    'highlight-colors'],
  \ 'g':    ['Twiggy',         'twiggy'],
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
autocmd FileType rust let g:localleader_key_map.l = {
  \ 'name': '+rust-analyzer',
  \ 'm':    [':CocCommand rust-analyzer.expandMacro',   'expand-macro'],
  \ 'p':    [':CocCommand rust-analyzer.parentModule',  'parent-module'],
  \ 's':    [':CocCommand rust-analyzer.ssr',           'structural-search-replace'],
  \ 'c':    [':CocCommand rust-analyzer.openCargoToml', 'open-cargo-toml'],
  \ }

nmap <space>e :CocCommand explorer<CR>

call which_key#register('<Space>', "g:leader_key_map")
call which_key#register('\', "g:localleader_key_map")

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  '\'<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual  '\'<CR>
