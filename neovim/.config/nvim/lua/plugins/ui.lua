return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  { "bufferline.nvim", enabled = false },

  {
    "lualine.nvim",
    keys = {
      {
        "<Leader><Tab>r",
        function()
          local name = vim.fn.input("Tab name: ")
          vim.cmd(":LualineRenameTab " .. name)
        end,
        desc = "Rename Tab",
      },
    },
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = require("lazyvim.config").icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          always_show_tabline = false,
          theme = "auto",
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "alpha" }, winbar = { "alpha", "neo-tree" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },

          lualine_c = {
            -- stylua: ignore
            {
              function() return "[noeol]" end,
              cond = function() return not vim.bo.eol end,
            },
            LazyVim.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
          },
          lualine_x = {
            -- stylua: ignore
            {
              function() return vim.bo.spelllang end,
              cond = function() return vim.wo.spell end,
            },
            "encoding",
            "fileformat",
            -- stylua: ignore
            {
              function() return vim.fn.SleuthIndicator() end,
              cond = function() return vim.g.loaded_sleuth == 1 end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return LazyVim.ui.fg("Statement") end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return LazyVim.ui.fg("Constant") end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return LazyVim.ui.fg("Debug") end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return LazyVim.ui.fg("Special") end,
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        extensions = { "lazy", "neo-tree", "nvim-dap-ui", "toggleterm", "trouble" },
        tabline = {
          lualine_a = { { "tabs", max_length = vim.o.columns, mode = 2 } },
          lualine_z = { { "filename", file_status = false, path = 4, shorting_target = 80 } },
        },
        winbar = {
          lualine_c = {},
          lualine_y = {
            { LazyVim.lualine.pretty_path() },
          },
        },
        inactive_winbar = {
          lualine_c = {},
          lualine_y = {
            { LazyVim.lualine.pretty_path() },
          },
        },
      }

      -- do not add trouble symbols if aerial is enabled
      if vim.g.trouble_lualine then
        local trouble = require("trouble")
        local symbols = trouble.statusline
          and trouble.statusline({
            mode = "symbols",
            groups = {},
            title = false,
            filter = { range = true },
            format = "{kind_icon}{symbol.name:Normal}",
            hl_group = "lualine_c_normal",
          })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end

      return opts
    end,
  },
  ------------------------------ End modification ------------------------------
}
