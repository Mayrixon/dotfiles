return {
  {
    "ntpeters/vim-better-whitespace",
    event = "BufReadPost",
    keys = {
      { "<Leader>us", "<Cmd>StripWhitespace<CR>", mode = { "n", "v" }, desc = "Remove Trailing [S]pace" },
    },
    config = function()
      vim.g.better_whitespace_filetypes_blacklist = {
        "TelescopePrompt",
        "Trouble",
        "diff",
        "git",
        "gitcommit",
        "help",
        "markdown",
        "neo-tree",
        "qf",
        "terminal",
      }
      vim.g.better_whitespace_operator = ""
      vim.g.better_whitespace_ctermcolor = "Gray"
      vim.g.better_whitespace_guicolor = "Gray"
    end,
  },
}
