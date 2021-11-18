return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      -- if vim.fn.argc() == 1 then
      --   local stat = vim.loop.fs_stat(vim.fn.argv(0))
      --   if stat and stat.type == "directory" then
      --     require("oil")
      --   end
      -- end
    end,
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
      keymaps = {
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
      },
      use_default_keymaps = true,
    },
  },
}
