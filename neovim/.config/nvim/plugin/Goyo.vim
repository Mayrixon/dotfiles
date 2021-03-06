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

  setlocal scrolloff=999
  setlocal linebreak

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

  setlocal scrolloff<
  setlocal linebreak<

  unmap j
  unmap k

  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" changing from the default 80 to accomodate for UndoTree panel
let g:goyo_width = 104

let g:leader_key_map.z = {
  \ 'name': '+zen-mode',
  \ 'z':    [':Goyo',        'toggle-zen-mode'],
  \ 'l':    {
  \     'name': '+Limelight',
  \     'l':    [':Limelight',  'turn-on-limelight'],
  \     'k':    [':Limelight!', 'turn-off-limelight'],
  \     }
  \ }
