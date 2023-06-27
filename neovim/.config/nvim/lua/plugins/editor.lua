local Util = require("util")

return {
  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      {
        "<Leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("util").get_root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<Leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    cmd = "Neotree",
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    opts = function()
      local icons = require("config").icons
      return {
        sources = {
          "filesystem",
          "buffers",
          "git_status",
        },
        open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy", "Outline" }, -- when opening files, do not use windows containing these filetypes or buftypes
        window = {
          mappings = {
            -- Disable <Space> because of leader keymaps
            ["<Space>"] = "none",
            ["<Tab>"] = "toggle_node",
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
            ["w"] = "none",
          },
        },
        source_selector = {
          winbar = true,
          sources = {
            { source = "filesystem" },
            { source = "git_status" },
            { source = "buffers" },
          },
        },
        event_handlers = {
          {
            event = "file_open_requested",
            handler = function(args)
              if args.open_cmd == "tabnew" then
                vim.cmd("Neotree close")
                vim.cmd("tabnew")
                vim.cmd("edit " .. args.path)
                return { handled = true }
              else
                return { handled = false }
              end
            end,
          },
        },
        default_component_configs = {
          diagnostics = {
            symbols = icons.diagnostics,
          },
          indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
          },
          git_status = {
            symbols = icons.git,
          },
        },
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
      }
    end,
  },

  -- Search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      {
        "<Leader>sr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        event = "VeryLazy",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "nvim-telescope/telescope-frecency.nvim",
        event = "VeryLazy",
        config = function()
          require("telescope").load_extension("frecency")
        end,
        dependencies = { "kkharji/sqlite.lua" },
      },
    },
    enabled = vim.fn.has("nvim-0.9.0") == 1,
    cmd = "Telescope",
    keys = {
      { "<Leader>,", "<Cmd>Telescope buffers show_all_buffers=true<CR>", desc = "Switch Buffer" },
      { "<Leader>:", "<Cmd>Telescope command_history<CR>", desc = "Command History" },
      -- Find
      { "<Leader>fb", "<Cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<Leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
      { "<Leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<Leader>fr", "<Cmd>Telescope frecency<CR>", desc = "Recent" },
      { "<Leader>fR", "<Cmd>Telescope frecency workspace=CWD<CR>", desc = "Recent (cwd)" },
      -- Git
      { "<Leader>gc", "<Cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<Leader>gs", "<Cmd>Telescope git_status<CR>", desc = "status" },
      -- Search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<Leader>sa", "<Cmd>Telescope autocommands<CR>", desc = "Auto Commands" },
      { "<Leader>sb", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer" },
      { "<Leader>sc", "<Cmd>Telescope command_history<CR>", desc = "Command History" },
      { "<Leader>sC", "<Cmd>Telescope commands<CR>", desc = "Commands" },
      { "<Leader>sd", "<Cmd>Telescope diagnostics bufnr=0<CR>", desc = "Document diagnostics" },
      { "<Leader>sD", "<Cmd>Telescope diagnostics<CR>", desc = "Workspace diagnostics" },
      { "<Leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<Leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<Leader>sh", "<Cmd>Telescope help_tags<CR>", desc = "Help Pages" },
      { "<Leader>sH", "<Cmd>Telescope highlights<CR>", desc = "Search Highlight Groups" },
      { "<Leader>sk", "<Cmd>Telescope keymaps<CR>", desc = "Key Maps" },
      { "<Leader>sm", "<Cmd>Telescope marks<CR>", desc = "Jump to Mark" },
      { "<Leader>sM", "<Cmd>Telescope man_pages<CR>", desc = "Man Pages" },
      { "<Leader>so", "<Cmd>Telescope vim_options<CR>", desc = "Options" },
      { "<Leader>sR", "<Cmd>Telescope resume<CR>", desc = "Resume" },
      {
        "<Leader>ss",
        Util.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
      {
        "<Leader>sS",
        Util.telescope("lsp_dynamic_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol (Workspace)",
      },
      { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
      { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
      { "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
      { "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
      { "<Leader>uc", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-B>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-F>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<M-i>"] = function()
              local action_state = require("telescope.actions.state")
              local line = action_state.get_current_line()
              Util.telescope("find_files", { no_ignore = true, default_text = line })()
            end,
            ["<M-h>"] = function()
              local action_state = require("telescope.actions.state")
              local line = action_state.get_current_line()
              Util.telescope("find_files", { hidden = true, default_text = line })()
            end,
            ["<M-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<M-T>"] = function(...)
              return require("trouble.providers.telescope").open_selected_with_trouble(...)
            end,
          },
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
            ["<M-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
          },
        },
      },
      extensions = {
        frecency = {
          -- TODO: move these folder path to lua/config or local settings
          workspaces = {
            ["dotfiles"] = vim.env.HOME .. "/" .. "dotfiles",
            ["notes"] = vim.env.HOME .. "/" .. "notes",
          },
        },
      },
    },
  },

  -- Add Flash
  {
    "folke/flash.nvim",
    version = "*",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {
      modes = { search = { enabled = false } },
    },
    -- stylua: ignore
    keys = {
      { "gz", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "gZ", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<C-S>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- Flash Telescope config
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function(_, opts)
      if not require("util").has("flash.nvim") then
        return
      end
      local function flash(prompt_bufnr)
        require("flash").jump({
          pattern = "^",
          label = { after = { 0, 0 } },
          search = {
            mode = "search",
            exclude = {
              function(win)
                return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
              end,
            },
          },
          action = function(match)
            local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
          end,
        })
      end
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = { n = { s = flash }, i = { ["<C-S>"] = flash } },
      })
    end,
  },

  -- Key hints
  {
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        plugins = {
          registers = true,
        },
        defaults = {
          mode = { "n", "v" },
          ["["] = { name = "+Prev" },
          ["]"] = { name = "+Next" },
          ["g"] = { name = "+Goto" },
          ["<Leader><Tab>"] = { name = "+Tabs" },
          ["<Leader>T"] = { name = "+Toggle Options" },
          ["<Leader>b"] = { name = "+Buffer" },
          ["<Leader>c"] = { name = "+Code" },
          ["<Leader>f"] = { name = "+File/Find" },
          ["<Leader>g"] = { name = "+Git" },
          ["<Leader>gh"] = { name = "+Hunks" },
          ["<Leader>q"] = { name = "+Quit/Session" },
          ["<Leader>s"] = { name = "+Search" },
          ["<Leader>u"] = { name = "+Utilities" },
          ["<Leader>w"] = { name = "+Windows" },
          ["<Leader>x"] = { name = "+Diagnostics/Quickfix" },
        },
      },
      config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.register(opts.defaults)
      end,
    },
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, "Prev Hunk")

        -- Actions
        map({ "n", "v" }, "<Leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<Leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<Leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<Leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<Leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<Leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<Leader>ghb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<Leader>ghd", gs.diffthis, "Diff This")
        map("n", "<Leader>ghD", function()
          gs.diffthis("~")
        end, "Diff This ~")
        map("n", "<Leader>Tb", gs.toggle_current_line_blame, "Toggle Current Line [B]lame")
        map("n", "<Leader>TD", gs.toggle_deleted, "Toggle Deleted Git Hunks")

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  -- References
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      filetypes_denylist = { "neotree", "terminal" },
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp", "treesitter" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_augroup("illuminate_config", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },

  -- Buffer remove
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<Leader>bd",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete Buffer",
      },
      {
        "<Leader>bD",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete Buffer (Force)",
      },
    },
  },

  -- Better diagnostics list and others
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
      { "<Leader>xx", "<Cmd>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics (Trouble)" },
      { "<Leader>xX", "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics (Trouble)" },
      { "<Leader>xL", "<Cmd>TroubleToggle loclist<CR>", desc = "Location List (Trouble)" },
      { "<Leader>xQ", "<Cmd>TroubleToggle quickfix<CR>", desc = "Quickfix List (Trouble)" },
    },
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      { "<Leader>xt", "<Cmd>TodoTrouble<CR>", desc = "Todo (Trouble)" },
      { "<Leader>xT", "<Cmd>TodoTrouble keywords=TODO,FIX,FIXME<CR>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<Leader>st", "<Cmd>TodoTelescope<CR>", desc = "Todo" },
      { "<Leader>sT", "<Cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>", desc = "Todo/Fix/Fixme" },
    },
  },
}
