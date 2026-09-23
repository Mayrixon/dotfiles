return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  {
    "gbprod/yanky.nvim",
    keys = {
      { "<Leader>p", false },
      {
        "<Leader>P",
        function()
          if LazyVim.pick.picker.name == "telescope" then
            require("telescope").extensions.yank_history.yank_history({})
          elseif LazyVim.pick.picker.name == "snacks" then
            Snacks.picker.yanky()
          else
            vim.cmd([[YankyRingHistory]])
          end
        end,
        mode = { "n", "x" },
        desc = "Open Yank History",
      },
    },
  },
  ------------------------------ End modification ------------------------------
}
