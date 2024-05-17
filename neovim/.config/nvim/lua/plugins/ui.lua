return {
  -- Better `vim.notify()`
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<Leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss All Notifications",
      },
    },
    opts = {
      stages = "static",
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      if not MyVim.has("noice.nvim") then
        MyVim.on_very_lazy(function()
          vim.notify = require("notify")
        end)
      end
    end,
  },

  -- Better vim.ui
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
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
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = require("config").icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local file_symbols = { modified = " 󰷈 ", readonly = " 󰌾 ", unnamed = " 󰡯 " }
      return {
        options = {
          theme = "auto",
          globalstatus = true,
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
            MyVim.lualine.root_dir(),
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
            { MyVim.lualine.pretty_path() },
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
              color = MyVim.ui.fg("Statement"),
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = MyVim.ui.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = MyVim.ui.fg("Debug"),
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = MyVim.ui.fg("Special"),
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
            { MyVim.lualine.pretty_path() },
          },
        },
        inactive_winbar = {
          lualine_c = {},
          lualine_y = {
            { MyVim.lualine.pretty_path() },
          },
        },
      }
    end,
    config = function(_, opts)
      require("lualine").setup(opts)
      -- HACK: This part is used to reset `showtabline = 1` instead of `showtabline = 2` as the hardcoded value now.
      -- After the merge of PR #1013, this part could be replaced as `opts.always_show_tabs = false`.
      require("lualine").hide({ place = { "tabline" } })
      local lualine_tmp = vim.api.nvim_create_augroup("lualine_tmp", { clear = true })
      vim.api.nvim_create_autocmd({ "TabNew", "TabClosed" }, {
        group = lualine_tmp,
        callback = function()
          if vim.fn.tabpagenr("$") == 1 then
            require("lualine").hide({ place = { "tabline" } })
          else
            require("lualine").hide({ place = { "tabline" }, unhide = true })
          end
        end,
      })
    end,
  },

  -- Indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = {
      indent = {
        char = "|",
        -- tab_char = "│",
      },
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    main = "ibl",
  },

  -- Displays a popup with possible key bindings of the command you started typing
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      if MyVim.has("noice.nvim") then
        opts.defaults["<Leader>sn"] = { name = "+Noice" }
      end
    end,
  },

  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<Leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<Leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<Leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<Leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<Leader>snt", function() require("noice").cmd("telescope") end, desc = "Noice Telescope" },
      { "<C-F>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = { "i", "n", "s" } },
      { "<C-B>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = { "i", "n", "s" } },
    },
  },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },

  {
    "nvimdev/dashboard-nvim",
    lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
    opts = function()
      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
        -- stylua: ignore
        center = {
            { action = MyVim.telescope("files"),                                    desc = " Find File",       icon = " ", key = "f" },
            { action = "ene | startinsert",                                        desc = " New File",        icon = " ", key = "n" },
            { action = "Telescope oldfiles",                                       desc = " Recent Files",    icon = " ", key = "r" },
            { action = "Telescope live_grep",                                      desc = " Find Text",       icon = " ", key = "g" },
            { action = [[lua MyVim.telescope.config_files()()]],         desc = " Config",          icon = " ", key = "c" },
            { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
            { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
            { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
        },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
}
