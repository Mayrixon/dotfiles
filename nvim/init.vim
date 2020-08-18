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

let g:vimtex_compiler_progname = 'nvr'
