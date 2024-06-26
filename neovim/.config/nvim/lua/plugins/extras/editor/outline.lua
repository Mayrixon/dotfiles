
return {
  {
    "hedyhli/outline.nvim",
    event = "LazyFile",
    keys = {
      { "<F2>", "<Cmd>Outline<CR>", desc = "Toggle Outline" },
    },
    cmd = "Outline",
    opts = function()
      local Config = require("config")
      local defaults = require("outline.config").defaults
      local opts = {
        symbols = {},
        symbol_blacklist = {},
      }
      local filter = Config.kind_filter

      if type(filter) == "table" then
        filter = filter.default
        if type(filter) == "table" then
          for kind, symbol in pairs(defaults.symbols) do
            opts.symbols[kind] = {
              icon = Config.icons.kinds[kind] or symbol.icon,
              hl = symbol.hl,
            }
            if not vim.tbl_contains(filter, kind) then
              table.insert(opts.symbol_blacklist, kind)
            end
          end
        end
      end
      return opts
    end,
  },

  -- edgy integration
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      local edgy_idx = MyVim.plugin.extra_idx("ui.edgy")
      local symbols_idx = MyVim.plugin.extra_idx("editor.outline")

      if edgy_idx and edgy_idx > symbols_idx then
        MyVim.warn("The `edgy.nvim` extra must be **imported** before the `outline.nvim` extra to work properly.", {
          title = "Plugin",
        })
      end

      opts.right = opts.right or {}
      table.insert(opts.right, {
        title = "Outline",
        ft = "Outline",
        pinned = true,
        open = "Outline",
      })
    end,
  },
}
