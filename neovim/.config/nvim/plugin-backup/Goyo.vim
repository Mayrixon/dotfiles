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
  setlocal signcolumn=no

  setlocal scrolloff=999
  setlocal linebreak

  map j gj
  map k gk

  LspStop
  Limelight
  " Disable compe
  call compe#setup({'enabled': v:false})
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
  set signcolumn<

  set scrolloff<
  set linebreak<

  unmap j
  unmap k

  Limelight!
  LspStart
  " Enable compe
  call compe#setup(g:compe)
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()