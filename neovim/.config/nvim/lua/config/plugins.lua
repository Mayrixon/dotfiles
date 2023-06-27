-- Automatically install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.extras.coding" },
    { import = "plugins.extras.dap" },
    { import = "plugins.extras.editor" },
    { import = "plugins.extras.formatting" },
    { import = "plugins.extras.lang" },
    { import = "plugins.extras.linting" },
    { import = "plugins.extras.test" },
    { import = "plugins.extras.treesitter" },
  },
  install = {
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "gruvbox", "habamax" },
  },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
