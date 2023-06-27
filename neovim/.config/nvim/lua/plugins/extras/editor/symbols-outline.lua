return {
  {
    "simrat39/symbols-outline.nvim",
    event = "BufReadPost",
    keys = {
      { "<F2>", "<Cmd>SymbolsOutline<CR>", desc = "Symbols Outline" },
    },
    opts = function()
      local icons = require("config").icons
      local opts = { symbols = {} }
      for key, value in pairs(icons.kinds) do
        opts.symbols[key] = { icon = value }
      end
      return opts
    end,
    config = true,
  },
}
