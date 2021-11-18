return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<Leader>r"] = { name = "+REPLs" },
      },
    },
  },
  {
    "michaelb/sniprun",
    version = "*",
    build = "sh ./install.sh",
    keys = {
      { "<Leader>rR", "<Plug>SnipReset", mode = "n", desc = "Reset SnipRun" },
      { "<Leader>rc", "<Plug>SnipClose", mode = "n", desc = "Close SnipRun" },
      { "<Leader>ri", "<Plug>SnipInfo", mode = "n", desc = "SnipRun [I]nfo" },
      { "<Leader>rm", "<Plug>SnipMemoryClean", mode = "n", desc = "Clean SnipRun [M]emory" },
      { "<Leader>rr", "<Plug>SnipRun", mode = { "n", "v" }, desc = "Run Snippets" },
    },
    cmd = { "SnipRun" },
    opts = {
      display = {
        "VirtualTextOk",
        "TerminalWithCode",
      },
    },
  },
}
