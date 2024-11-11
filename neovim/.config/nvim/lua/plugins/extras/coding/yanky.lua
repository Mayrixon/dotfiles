return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  {
    "gbprod/yanky.nvim",
    enabled = false,
    keys = {
      { "<Leader>p", false },
      -- stylua: ignore
      { "<Leader>fp", function() require("telescope").extensions.yank_history.yank_history({ }) end, desc = "Open Yank History" },
    },
  },
  ------------------------------ End modification ------------------------------
}
