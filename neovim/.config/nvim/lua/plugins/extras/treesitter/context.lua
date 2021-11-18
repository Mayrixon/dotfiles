return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    keys = {
      {
        "[c",
        function()
          require("treesitter-context").go_to_context()
        end,
        desc = "Jump to Context",
        silent = true,
      },
      {
        "<Leader>Tx",
        function()
          require("treesitter-context").toggle()
        end,
        desc = "Toggle Context",
      },
    },
    config = true,
  },
}
