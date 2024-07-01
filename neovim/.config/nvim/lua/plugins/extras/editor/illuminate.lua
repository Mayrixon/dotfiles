return {
  {
    "RRethy/vim-illuminate",
    opts = {
      filetypes_denylist = { "neotree", "terminal" },
      large_file_overrides = {
        providers = { "lsp", "treesitter" },
      },
    },
  },
}
