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
