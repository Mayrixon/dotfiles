require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.extras.coding" },
    { import = "plugins.extras.dap" },
    { import = "plugins.extras.editor" },
    { import = "plugins.extras.lang" },
    { import = "plugins.extras.lsp" },
    { import = "plugins.extras.test" },
    { import = "plugins.extras.testing" },
    { import = "plugins.extras.ui" },
    { import = "plugins.extras.util" },
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
