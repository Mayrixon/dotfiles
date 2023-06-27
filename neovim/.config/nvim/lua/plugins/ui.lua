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
    end,
    opts = function()
      local icons = require("config").icons
      local Util = require("util")

      local file_symbols = { modified = " 󰷈 ", readonly = " 󰌾 ", unnamed = " 󰡯 " }
      return {
        options = {
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
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = Util.fg("Special"),
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        tabline = {
          lualine_a = { { "tabs", max_length = vim.o.columns, mode = 2 } },
          lualine_z = { { "filename", file_status = false, path = 4, shorting_target = 80 } },
        },
        winbar = {
          lualine_c = {
            {
              "navic",
              padding = { right = 0 },
              color_correction = "dynamic",
              navic_opts = {
                click = true,
                depth_limit = 5,
                highlight = true,
              },
              cond = function()
                return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
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
              "navic",
              padding = { right = 0 },
              color_correction = "static",
              navic_opts = {
                depth_limit = 5,
                highlight = true,
              },
              cond = function()
                return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
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
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "│",
      filetype_exclude = {
        "help",
        "alpha",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
      },
      show_trailing_blankline_indent = false,
      show_current_context = false,
      use_treesitter = true,
    },
  },

  -- Active indent guide and indent text objects
  {
    "echasnovski/mini.indentscope",
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

  -- Noicer UI
  {
    "folke/which-key.nvim",
    optional = true,
    opts = function(_, opts)
      if require("util").has("noice.nvim") then
        opts.defaults["<Leader>sn"] = { name = "+Noice" }
      end
    end,
  },
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
        lsp_doc_border = true,
      },
    },
    keys = {
      {
        "<C-B>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<C-B>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = { "i", "n", "s" },
      },
      {
        "<C-F>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<C-F>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = { "i", "n", "s" },
      },
      {
        "<S-Enter>",
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline",
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
        "<Leader>snh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },
      {
        "<Leader>snl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last Message",
      },
      {
        "<Leader>snt",
        function()
          require("noice").cmd("telescope")
        end,
        desc = "Noice Telescope",
      },
    },
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<Leader>ba", "<Cmd>Alpha<CR>", "Open Dashboard" },
    },
    opts = function()
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <CR>]]),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      dashboard.opts.layout[1].val = 8

      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  -- LSP symbol navigation
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    lazy = true,
    init = function()
      require("util").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        icons = require("config").icons.kinds,
      }
    end,
  },

  -- Icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- UI components
  { "MunifTanjim/nui.nvim", lazy = true },
}
