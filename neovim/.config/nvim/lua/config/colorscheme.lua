local utils = require('utils')

utils.opt('w', 'cursorline', true)

utils.opt('o', 'termguicolors', true)
utils.opt('o', 'background', 'dark')
vim.g.gruvbox_italic = 1

vim.cmd [[colorscheme gruvbox]]
