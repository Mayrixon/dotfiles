" TODO: add <leader 1> to <leader 0> to switch tabs.
let mapleader = ' '
let maplocalleader = '\'

noremap <F2> :Vista!!<CR>

noremap <localleader>y "+y
noremap <localleader>p "+p

" coc.nvim {{{
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <C-space> to trigger completion.
inoremap <silent><expr> <C-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Return expr for scrolling a floating window forward or backward.
nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for GOTO-s
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap for format the whole buffer
xmap <leader>F  <Plug>(coc-format)
nmap <leader>F  <Plug>(coc-format)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>la  :<C-u>CocList diagnostics<CR>
" Show commands
nnoremap <silent> <leader>lc  :<C-u>CocList commands<CR>
" Manage extensions
nnoremap <silent> <leader>le  :<C-u>CocList extensions<CR>
" Show a new coc list
nnoremap <silent> <leader>lg  :<C-u>CocList<CR>
" Do default action for next item.
nnoremap <silent> <leader>lj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>lk  :<C-u>CocPrev<CR>
" Match lines of current buffer by regexp
nnoremap <silent> <leader>ll  :<C-u>CocList lines<CR>
" Find symbol of current document
nnoremap <silent> <leader>lo  :<C-u>CocList outline<CR>
" Resume latest coc list
nnoremap <silent> <leader>lp  :<C-u>CocListResume<CR>
" Search workspace symbols
nnoremap <silent> <leader>ls  :<C-u>CocList -I symbols<CR>
nnoremap <silent> <leader>ly  :<C-u>CocList -A --normal yank<CR>

" }}}

" EasyAlign {{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}

let g:which_key_run_map_on_popup = 1
let g:which_key_use_floating_win = 1

set timeoutlen=500
let g:leader_key_map   = {
  \ 'a':     'cocaction',
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

call which_key#register('<Space>', "g:leader_key_map")
call which_key#register('\', "g:localleader_key_map")

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  '\'<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual  '\'<CR>

:nmap <space>e :CocCommand explorer<CR>


