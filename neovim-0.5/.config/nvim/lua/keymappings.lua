local utils = require('utils')

-- Map leader and local leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

utils.map('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
utils.map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')

local wk = require('which-key')

wk.register({
    f = {
        name = 'fuzzy finder',
        b = {'<cmd>Telescope buffers<CR>', 'buffers'},
        f = {'<cmd>Telescope find_files<CR>', 'find files'},
        g = {'<cmd>Telescope live_grep<CR>', 'live grep'},
        h = {'<cmd>Telescope help_tags<CR>', 'help tags'},
    },
}, {prefix = '<leader>'})
