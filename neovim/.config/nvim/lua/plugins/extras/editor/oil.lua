return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {
        "<Leader>f-",
        function()
          require("oil").open()
        end,
        desc = "Open Oil file manager",
      },
    },
    cmd = "Oil",
    opts = {
      use_default_keymaps = true,
    },
  },
}
