local utils = require('utils')

-- Map leader and local leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

utils.map('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
utils.map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')
