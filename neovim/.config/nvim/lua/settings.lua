-- Remote providers
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = '/usr/bin/python3'

vim.cmd [[
  syntax enable
  filetype plugin indent on
]]

-- Global settings
vim.opt.ttimeoutlen = 100

vim.opt.mouse = 'a'

vim.opt.hidden = true

vim.opt.display = 'msgsep'

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'nosplit'

vim.opt.lazyredraw = true
-- vim.opt.synmaxcol=500

vim.opt.wildmode = 'longest,full'

vim.opt.showmatch = true

-- Window-local settings
vim.opt_global.scrolloff = 4
vim.opt_global.sidescrolloff = 4

vim.opt_global.listchars = 'tab:> ,trail:-,extends:>,precedes:<,nbsp:+'
vim.opt_global.list = true

vim.opt_global.number = true
vim.opt_global.relativenumber = true
vim.opt_global.signcolumn = 'yes'

vim.opt_global.foldmethod = 'syntax'

vim.opt_global.conceallevel = 1
vim.opt_global.concealcursor = 'nc'

-- Buffer-local settings
local indent = 4
vim.opt_global.expandtab = true
vim.opt_global.shiftwidth = indent
vim.opt_global.smartindent = true
vim.opt_global.tabstop = indent

-- Highlight on yank
vim.cmd [[
  autocmd TextYankPost * lua vim.highlight.on_yank {on_visual = false}
]]
