local utils = require('utils')

-- Map leader and local leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

utils.map('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
utils.map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')

local wk = require('which-key')

wk.setup({
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    ['<SPACE>'] = 'SPC',
    ['<CR>'] = 'RET',
    ['<TAB>'] = 'TAB'
  }
})

wk.register({
  f = {
    name = 'fuzzy finder',
    b = {'<cmd>Telescope buffers<CR>', 'buffers'},
    f = {'<cmd>Telescope find_files<CR>', 'find files'},
    g = {'<cmd>Telescope live_grep<CR>', 'live grep'},
    h = {'<cmd>Telescope help_tags<CR>', 'help tags'},
    p = {'<cmd>Telescope<CR>', 'pickers'}
  },
  z = {
    name = 'zen mode',
    l = {
      name = 'limelight',
      k = {'<cmd>Limelight!<CR>', 'turn off'},
      l = {'<cmd>Limelight<CR>', 'turn on'}
    },
    z = {'<cmd>Goyo<CR>', 'toggle zen mode'}
  },
  ['<SPACE>'] = {
    name = 'fast move to',
    f = {'<cmd>HopChar1<CR>', '1 char word'},
    g = {'<cmd>HopChar2<CR>', '2 chars word'},
    l = {'<cmd>HopLine<CR>', 'line'},
    w = {'<cmd>HopWord<CR>', 'word'}
  }
}, {prefix = '<leader>'})

wk.register({f = {'<cmd>Format<CR>', 'format'}}, {prefix = '<localleader>'})
