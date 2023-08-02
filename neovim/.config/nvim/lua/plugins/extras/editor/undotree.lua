return {
  {
    "mbbill/undotree",
    event = "VeryLazy",
    cmd = "UndotreeToggle",
    keys = {
      { "<Leader>uu", "<Cmd>UndotreeToggle<CR>", desc = "Undotree" },
    },
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SplitWidth = 40
      vim.g.undotree_DiffpanelHeight = 10
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
}
