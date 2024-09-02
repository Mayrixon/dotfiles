return {
  {
    "nvim-telescope/telescope-frecency.nvim",
    keys = {
      { "<Leader>fr", "<Cmd>Telescope frecency<CR>", desc = "Frecency recent" },
    },
    config = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("frecency")
      end)
    end,
  },
}
