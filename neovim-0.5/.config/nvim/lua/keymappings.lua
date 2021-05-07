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
        h = {'<cmd>Telescope help_tags<CR>', 'help tags'}
    },
    z = {
        name = 'zen mode',
        l = {
            name = 'limelight',
            k = {'<cmd>Limelight!<CR>', 'turn off'},
            l = {'<cmd>Limelight<CR>', 'turn on'}
        },
        z = {'<cmd>Goyo<CR>', 'toggle zen mode'}
    }
}, {prefix = '<leader>'})

wk.register({f = {'<cmd>Format<CR>', 'format'}}, {prefix = '<localleader>'})
