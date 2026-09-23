return {
  {
    "RRethy/vim-illuminate",
    opts = {
      filetypes_denylist = { "terminal" },
      large_file_overrides = {
        providers = { "lsp", "treesitter" },
      },
    },
  },
}
