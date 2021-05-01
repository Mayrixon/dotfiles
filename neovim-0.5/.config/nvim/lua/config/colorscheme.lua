local utils = require('utils')

-- TODO: config to the right color. BG color is deeper than need.
utils.opt('o', 'termguicolors', true)
utils.opt('o', 'background', 'dark')
vim.g.gruvbox_italic = 1
vim.cmd [[colorscheme gruvbox]]
