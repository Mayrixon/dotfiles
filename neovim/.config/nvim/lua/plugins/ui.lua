return {
  -- Better `vim.notify()`
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      local Util = require("util")
      if not Util.has("noice.nvim") then
        Util.on_very_lazy(function()
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

  -- Statusline
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
      vim.opt.laststatus = 3
      vim.opt.shortmess:append({ W = true }) -- W don't give written sign
      vim.opt.showmode = false -- Don't show mode since we have a statusline

      vim.g.lualine_laststatus = vim.o.laststatus
      vim.o.laststatus = 0
    end,
    opts = function()
      local icons = require("config").icons
      local Util = require("util")

      local navic = require("nvim-navic")

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
            { "filename", path = 1, symbols = file_symbols },
          },
          lualine_x = {
            {
              function()
                return vim.bo.spelllang
              end,
              cond = function()
                return vim.wo.spell
              end,
            },
            "encoding",
            "fileformat",
            {
              function()
                return vim.fn.SleuthIndicator()
              end,
              cond = function()
                return vim.g.loaded_sleuth == 1
              end,
            },
            {
              -- Display keystrokes such as `gcc`
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = Util.fg("Statement"),
            },
            {
              -- Display mode such as `recording @q`
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.mode.has()
              end,
              color = Util.fg("Constant"),
            },
            {
              function()
                return "  " .. require("dap").status()
              end,
              cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
              end,
              color = Util.fg("Debug"),
            },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Util.fg("Special") },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
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
        tabline = {
          lualine_a = { { "tabs", max_length = vim.o.columns, mode = 2 } },
          lualine_z = { { "filename", file_status = false, path = 4, shorting_target = 80 } },
        },
        winbar = {
          lualine_c = {
            {
              function()
                return navic.get_location()
              end,
              padding = { right = 0 },
              color_correction = "dynamic",
              cond = function()
                return navic.is_available()
              end,
            },
          },
          lualine_y = {
            { "filename", symbols = file_symbols },
          },
        },
        inactive_winbar = {
          lualine_c = {
            {
              function()
                return navic.get_location()
              end,
              padding = { right = 0 },
              color_correction = "static",
              cond = function()
                return navic.is_available()
              end,
            },
          },
          lualine_y = { { "filename", symbols = file_symbols } },
        },
        extensions = { "lazy", "neo-tree", "nvim-dap-ui", "toggleterm", "trouble" },
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
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "|" },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
        },
      },
    },
    main = "ibl",
  },

  -- Active indent guide and indent text objects. When you're browsing
  -- code, this highlights the current level of indentation, and animates
  -- the highlighting.
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      return {
        draw = {
          animation = require("mini.indentscope").gen_animation.exponential({ duration = 100, unit = "total" }),
        },
        symbol = "│",
        options = { try_as_border = true },
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      if require("util").has("noice.nvim") then
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
    keys = {
      {
        "<S-Enter>",
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline",
      },
      {
        "<Leader>snl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last Message",
      },
      {
        "<Leader>snh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },
      {
        "<Leader>sna",
        function()
          require("noice").cmd("all")
        end,
        desc = "Noice All",
      },
      {
        "<Leader>snd",
        function()
          require("noice").cmd("dismiss")
        end,
        desc = "Dismiss All",
      },
      {
        "<C-F>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-f>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = { "i", "n", "s" },
      },
      {
        "<C-B>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = { "i", "n", "s" },
      },
    },
  },

  -- Dashboard. This runs when neovim starts, and is what displays
  -- the "LAZYVIM" banner.
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", "<Cmd> Telescope find_files <CR>"),
        dashboard.button("n", " " .. " New file", "<Cmd> ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", "<Cmd> Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", "<Cmd> Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", "<Cmd> e $MYVIMRC <CR>"),
        dashboard.button("s", " " .. " Restore Session", [[<Cmd> lua require("persistence").load() <CR>]]),
        dashboard.button("l", "󰒲 " .. " Lazy", "<Cmd> Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", "<Cmd> qa<CR>"),
      }
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          once = true,
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  -- lsp symbol navigation for lualine. This shows where
  -- in the code structure you are - within functions, classes,
  -- etc - in the statusline.
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require("util").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        -- separator = " ",
        highlight = true,
        depth_limit = 5,
        icons = require("config").icons.kinds,
        lazy_update_context = true,
      }
    end,
  },

  -- Icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- UI components
  { "MunifTanjim/nui.nvim", lazy = true },
}
