return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "<Leader>fo",
        function()
          require("oil").open()
        end,
        desc = "Open [O]il file manager",
      },
    },
    cmd = "Oil",
    opts = {
      use_default_keymaps = true,
    },
  },
}
