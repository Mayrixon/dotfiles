return {

  -- Measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Session management. This saves your session in the background,
  -- keeping track of open buffers, window arrangement, and more.
  -- You can restore sessions when returning through the dashboard.
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    -- stylua: ignore
    keys = {
      { "<Leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<Leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<Leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },

  -- Auto set buffer indent
  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
    keys = {
      { "<Leader>uS", "<Cmd>Sleuth<CR>", desc = "Sleuth" },
    },
  },

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },
}
