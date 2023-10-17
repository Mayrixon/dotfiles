local Util = require("util")

return {
  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<Leader>e", "<Leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<Leader>E", "<Leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      {
        "<Leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = Util.get_root() })
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
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = function()
      local icons = require("config").icons
      return {
        sources = { "filesystem", "buffers", "git_status" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy", "Outline" }, -- when opening files, do not use windows containing these filetypes or buftypes
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
        window = {
          mappings = {
            ["<space>"] = "none",
            ["<tab>"] = "toggle_node",
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
          diagnostics = { symbols = icons.diagnostics },
          indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
        },
      }
    end,
    config = function(_, opts)
      local function on_move(data)
        Util.on_rename(data.source, data.destination)
      end

      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
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

  -- Fuzzy finder.
  -- The default key bindings to find files will use Telescope's
  -- `find_files` or `git_files` depending on whether the
  -- directory is a git repo.
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
        config = function()
          Util.on_load("telescope.nvim", function()
            require("telescope").load_extension("fzf")
          end)
        end,
      },
      {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
          Util.on_load("telescope.nvim", function()
            require("telescope").load_extension("frecency")
          end)
        end,
        dependencies = { "kkharji/sqlite.lua" },
      },
    },
    keys = {
      { "<Leader>,", "<Cmd>Telescope buffers show_all_buffers=true<CR>", desc = "Switch Buffer" },
      { "<Leader>/", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      { "<Leader>:", "<Cmd>Telescope command_history<CR>", desc = "Command History" },
      { "<Leader><Space>", Util.telescope("files"), desc = "Find Files (root dir)" },
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
      { '<Leader>s"', "<cmd>Telescope registers<CR>", desc = "Registers" },
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
      { "<Leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
      { "<Leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
      { "<Leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
      { "<Leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
      { "<Leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
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
            "Enum",
            "Constant",
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
            "Enum",
            "Constant",
          },
        }),
        desc = "Goto Symbol (Workspace)",
      },
    },
    opts = function()
      local actions = require("telescope.actions")

      local open_with_trouble = function(...)
        return require("trouble.providers.telescope").open_with_trouble(...)
      end
      local open_selected_with_trouble = function(...)
        return require("trouble.providers.telescope").open_selected_with_trouble(...)
      end
      local find_files_no_ignore = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        Util.telescope("find_files", { no_ignore = true, default_text = line })()
      end
      local find_files_with_hidden = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        Util.telescope("find_files", { hidden = true, default_text = line })()
      end
      return {
        defaults = {
          mappings = {
            i = {
              ["<C-B>"] = actions.preview_scrolling_up,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-F>"] = actions.preview_scrolling_down,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<M-h>"] = find_files_with_hidden,
              ["<M-i>"] = find_files_no_ignore,
              ["<M-t>"] = open_with_trouble,
              ["<M-T>"] = open_selected_with_trouble,
            },
            n = {
              ["<M-t>"] = open_with_trouble,
              ["q"] = actions.close,
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
      }
    end,
  },

  -- Flash enhances the built-in search functionality by showing labels
  -- at the end of each match, letting you quickly jump to a specific
  -- location.
  {
    "folke/flash.nvim",
    event = "VeryLazy",
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

  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        spelling = true,
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

  -- git signs highlights text that has changed since the list
  -- git commit, and also lets you interactively stage & unstage
  -- hunks in a commit.
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
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

        -- Toggles
        map("n", "<Leader>Tb", gs.toggle_current_line_blame, "Toggle Current Line [B]lame")
        map("n", "<Leader>TD", gs.toggle_deleted, "Toggle Deleted Git Hunks")

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  -- Automatically highlights other instances of the word under your cursor.
  -- This works with LSP, Treesitter, and regexp matching to find the other
  -- instances.
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
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
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
      { "<Leader>xx", "<Cmd>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics (Trouble)" },
      { "<Leader>xX", "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics (Trouble)" },
      { "<Leader>xL", "<Cmd>TroubleToggle loclist<CR>", desc = "Location List (Trouble)" },
      { "<Leader>xQ", "<Cmd>TroubleToggle quickfix<CR>", desc = "Quickfix List (Trouble)" },
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
    },
  },

  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
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
