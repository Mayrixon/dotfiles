-- TODO: add local configs
-- local local_config = require(local_config)
-- TODO: add to a system-based config file.
-- local function provider_settings()
--   vim.g.loaded_python_provider = 0
--   -- vim.g.python3_host_prog = '/usr/bin/python3'
-- end

-- Global variables
_G.myvim_docs = true

-- Automatically install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("config").init()
require("config").setup()
