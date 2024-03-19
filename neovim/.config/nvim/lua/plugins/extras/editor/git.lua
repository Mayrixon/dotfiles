return {
  {
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        defaults = {
          ["<Leader>gd"] = { name = "+Diffview" },
        },
      },
    },
    {
      "sindrets/diffview.nvim",
      event = "VeryLazy",
      cmd = {
        "DiffviewOpen",
        "DiffviewFileHistory",
      },
      keys = {
        { "<Leader>gdc", "<Cmd>DiffviewClose<Cr>", desc = "Close Diffview" },
        { "<Leader>gdd", "<Cmd>DiffviewOpen<Cr>", desc = "Open [D]iffview" },
        { "<Leader>gdf", "<Cmd>DiffviewFocusFiles<CR>", desc = "Focus Current File" },
        { "<Leader>gdh", "<Cmd>DiffviewFileHistory<CR>", desc = "Open Currnet File [H]istory" },
      },
    },
  },

  {
    "TimUntersberger/neogit",
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    event = "VeryLazy",
    keys = {
      { "<Leader>gn", "<Cmd>Neogit<CR>", desc = "Open NeoGit" },
    },
    cmd = "Neogit",
    config = function()
      require("neogit").setup({ integrations = { telescope = true, diffview = true } })
    end,
  },

  { "akinsho/git-conflict.nvim", version = "*", config = true },
}
