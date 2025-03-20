-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-------------------------- Modified LazyVim's options --------------------------
-- Snacks animations
-- Set to `false` to globally disable all snacks animations
vim.g.snacks_animate = false

opt.clipboard = ""
opt.formatoptions = opt.formatoptions + "ronl" -- Default "tcqj"
opt.shiftwidth = 4 -- Size of an indent
opt.spelllang = { "en_us", "cjk" }
opt.tabstop = 4 -- Number of spaces tabs count for
opt.winminwidth = 0 -- Minimum window width
------------------------------- End modification -------------------------------

opt.breakindent = true -- Wrapped lines continue visually indented
opt.diffopt = "filler,internal,closeoff,indent-heuristic,linematch:60,algorithm:patience"
