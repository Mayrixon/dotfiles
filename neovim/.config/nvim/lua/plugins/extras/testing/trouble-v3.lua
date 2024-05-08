local Config = require("config")

if vim.tbl_contains(Config.json.data.extras, "plugins.extras.editor.trouble-v3") then
  for _, other in ipairs({ "aerial", "outline" }) do
    local extra = "plugins.extras.editor." .. other
    if vim.tbl_contains(Config.json.data.extras, extra) then
      other = other:gsub("^%l", string.upper)
      MyVim.error({
        "**Trouble v3** includes support for document symbols.",
        ("You currently have the **%s** extra enabled."):format(other),
        "Please disable it in your config.",
      })
    end
  end
end

return {
  {
    "folke/trouble.nvim",
    branch = "dev",
    keys = {
      { "<Leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
      { "<Leader>xX", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
      { "<Leader>cs", "<Cmd>Trouble symbols toggle focus=false<CR>", desc = "Symbols (Trouble)" },
      {
        "<Leader>cS",
        "<Cmd>Trouble lsp toggle focus=false win.position=right<CR>",
        desc = "LSP references/definitions/... (Trouble)",
      },
      { "<Leader>xL", "<Cmd>Trouble loclist toggle<CR>", desc = "Location List (Trouble)" },
      { "<Leader>xQ", "<Cmd>Trouble qflist toggle<CR>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
    },
  },

  -- lualine integration
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     local trouble = require("trouble")
  --     if not trouble.statusline then
  --       MyVim.error("You have enabled the **trouble-v3** extra,\nbut still need to update it with `:Lazy`")
  --       return
  --     end
  --
  --     local symbols = trouble.statusline({
  --       mode = "symbols",
  --       groups = {},
  --       title = false,
  --       filter = { range = true },
  --       format = "{kind_icon}{symbol.name:Normal}",
  --     })
  --     table.insert(opts.sections.lualine_c, {
  --       symbols.get,
  --       cond = symbols.has,
  --     })
  --   end,
  -- },

  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "trouble",
          filter = function(_buf, win)
            return vim.w[win].trouble
              and vim.w[win].trouble.position == pos
              and vim.w[win].trouble.type == "split"
              and vim.w[win].trouble.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function(_, opts)
      local open_with_trouble = require("trouble.sources.telescope").open
      return vim.tbl_deep_extend("force", opts, {
        defaults = {
          mappings = {
            i = {
              ["<M-t>"] = open_with_trouble,
            },
            n = {
              ["<M-t>"] = open_with_trouble,
            },
          },
        },
      })
    end,
  },
}
