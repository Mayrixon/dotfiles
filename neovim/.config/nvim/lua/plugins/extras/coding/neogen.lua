return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<Leader>i", group = "Insert" },
      },
    },
  },

  {
    "danymat/neogen",
    version = "*",
    keys = {
      { "<Leader>id", "<Cmd>Neogen<CR>", desc = "Document" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter", "L3MON4D3/LuaSnip" },
    opts = { snippet_engine = "luasnip" },
  },
}
