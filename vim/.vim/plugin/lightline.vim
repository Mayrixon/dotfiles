set noshowmode
set showtabline=2
set laststatus=2

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
