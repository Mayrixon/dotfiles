" setlocal nomodeline
set noshowmode
set showtabline=2

let g:bufferline_echo = 0
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''

" augroup lightline
"   autocmd!
"   autocmd Filetype * :call lightline#update()
" augroup END

function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

let g:lightline = {
  \ 'colorscheme': 'gruvbox',
		\ 'separator': { 'left': '', 'right': '' },
		\ 'subseparator': { 'left': '', 'right': '' },
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'readonly', 'filename', 'modified', 'lsp' ] ],
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
  \   'lsp': 'LspStatus',
  \   'filepath': 'LightlineAbsoluteFilePath',
  \   'gitbranch': 'fugitive#head',
  \   'sw': 'SleuthIndicator',
  \ },
  \ }
