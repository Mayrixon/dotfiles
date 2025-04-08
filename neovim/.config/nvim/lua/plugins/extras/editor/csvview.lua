return {
  {
    "hat0uma/csvview.nvim",
    keys = {
      { "<Leader>uc", "<Cmd>CsvViewToggle<CR>", desc = "[C]SV View Toggle" },
    },
    config = function()
      require("csvview").setup()
    end,
  },
}
