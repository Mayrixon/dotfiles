set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set undofile

let g:loaded_python_provider = 1
let g:python3_host_prog = '/usr/bin/python3'

call plug#begin('~/.local/share/nvim/plugged')
runtime! plugins.vim
call plug#end()

runtime! config.vim
runtime! keymaps.vim
runtime! coc-settings.vim

call which_key#register('<Space>', "g:leader_key_map")
call which_key#register('\', "g:localleader_key_map")

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  '\'<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual  '\'<CR>

let g:vimtex_compiler_progname = 'nvr'
