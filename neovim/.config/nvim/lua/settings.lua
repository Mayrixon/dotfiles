local utils = require('utils')

local cmd = vim.cmd
local indent = 4

-- Remote providers
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = '/usr/bin/python3'

cmd 'syntax enable'
cmd 'filetype plugin indent on'

-- Global settings
utils.opt('o', 'ttimeoutlen', 100)

utils.opt('o', 'mouse', 'a')

utils.opt('o', 'hidden', true)

utils.opt('o', 'display', 'msgsep')

utils.opt('o', 'ignorecase', true)
utils.opt('o', 'smartcase', true)
utils.opt('o', 'inccommand', 'nosplit')

utils.opt('o', 'lazyredraw', true)
-- utils.opt('o', 'synmaxcol', 500)

utils.opt('o', 'wildmode', 'longest,full')

utils.opt('o', 'showmatch', true)

-- Window-local settings
utils.opt('w', 'scrolloff', 4)
utils.opt('w', 'sidescrolloff', 4)

utils.opt('w', 'listchars', 'tab:> ,trail:-,extends:>,precedes:<,nbsp:+')
utils.opt('w', 'list', true)

utils.opt('w', 'number', true)
utils.opt('w', 'relativenumber', true)
utils.opt('w', 'signcolumn', 'yes')

utils.opt('w', 'foldmethod', 'syntax')

utils.opt('w', 'conceallevel', 1)
utils.opt('w', 'concealcursor', 'nc')

-- Buffer-local settings
utils.opt('b', 'expandtab', true)
utils.opt('b', 'shiftwidth', indent)
utils.opt('b', 'smartindent', true)
utils.opt('b', 'tabstop', indent)

-- Highlight on yank
cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
