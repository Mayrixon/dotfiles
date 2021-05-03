let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
			\ 'enter': { 'shift': 1 },
			\ 'links': { 'external': { 'enable': 1 } },
			\ 'map': { 'prefix': '<localleader>l', 'enable': 1 },
			\ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
			\ 'fold': { 'enable': 1 } }

let g:markdown_fenced_languages = ['python', 'rust']

if !exists('g:markdown_fenced_languages')
  let g:markdown_fenced_languages = []
endif
let s:done_include = {}
for s:type in map(copy(g:markdown_fenced_languages),'matchstr(v:val,"[^=]*$")')
  if has_key(s:done_include, matchstr(s:type,'[^.]*'))
    continue
  endif
  if s:type =~ '\.'
    let b:{matchstr(s:type,'[^.]*')}_subtype = matchstr(s:type,'\.\zs.*')
  endif
  exe 'syn include @markdownHighlight'.substitute(s:type,'\.','','g').' syntax/'.matchstr(s:type,'[^.]*').'.vim'
  unlet! b:current_syntax
  let s:done_include[matchstr(s:type,'[^.]*')] = 1
endfor
unlet! s:type
unlet! s:done_include

autocmd FileType markdown let g:localleader_key_map.l = {
  \ 'name': '+markdown',
  \ 'p':    {
  \     'name': '+preview',
  \     'l':    ['MarkdownPreview',     'preview'],
  \     'k':    ['MarkdownPreviewStop', 'stop-preview'],
  \     }
  \ }
