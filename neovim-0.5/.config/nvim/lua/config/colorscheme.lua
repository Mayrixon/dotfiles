local utils = require('utils')

utils.opt('o', 'termguicolors', true)
utils.opt('o', 'background', 'dark')
vim.g.gruvbox_italic = 1

-- TODO: config to the right color. BG color is deeper than need.
vim.cmd [[colorscheme gruvbox]]

-- TODO: config to original gruvbox
-- vim.cmd [[colorscheme gruvbox-material]]
