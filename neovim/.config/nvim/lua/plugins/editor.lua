local icons = require("config").icons
local have_make = vim.fn.executable("make") == 1
local have_cmake = vim.fn.executable("cmake") == 1

return {

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      {
        "<Leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = MyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<Leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<Leader>e", "<Leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
      { "<Leader>E", "<Leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
      -- because `cwd` is not set up properly.
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
          ["O"] = {
            function(state)
              require("lazy.util").open(state.tree:get_node().path, { system = true })
            end,
            desc = "Open with System Application",
          },
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
        git_status = {
          symbols = {
            unstaged = "󰄱",
            staged = "󰱒",
          },
        },
      },
    },
    config = function(_, opts)
      local function on_move(data)
        MyVim.lsp.on_rename(data.source, data.destination)
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
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<Leader>sr", function() require("spectre").open() end, desc = "Replace in Files (Spectre)" },
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
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = have_make == 1 and "make"
          or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        enabled = have_make == 1 or have_cmake == 1,
        config = function(plugin)
          MyVim.on_load("telescope.nvim", function()
            local ok, err = pcall(require("telescope").load_extension, "fzf")
            if not ok then
              local lib = plugin.dir .. "/build/libfzf." .. (MyVim.is_win() and "dll" or "so")
              if not vim.uv.fs_stat(lib) then
                MyVim.warn("`telescope-fzf-native.nvim` not built. Rebuilding...")
                require("lazy").build({ plugins = { plugin }, show = false }):wait(function()
                  MyVim.info("Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim.")
                end)
              else
                MyVim.error("Failed to load `telescope-fzf-native.nvim`:\n" .. err)
              end
            end
          end)
        end,
      },
      {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
          MyVim.on_load("telescope.nvim", function()
            require("telescope").load_extension("frecency")
          end)
        end,
      },
    },
    keys = {
      {
        "<Leader>,",
        "<Cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>",
        desc = "Switch Buffer",
      },
      { "<Leader>/", MyVim.telescope("live_grep"), desc = "Grep (Root Dir)" },
      { "<Leader>:", "<Cmd>Telescope command_history<CR>", desc = "Command History" },
      { "<Leader><Space>", MyVim.telescope("files"), desc = "Find Files (Root Dir)" },
      -- Find
      { "<Leader>fb", "<Cmd>Telescope buffers sort_mru=true sort_lastused=true<CR>", desc = "Buffers" },
      { "<leader>fc", MyVim.telescope.config_files(), desc = "Find Config File" },
      { "<Leader>ff", MyVim.telescope("files"), desc = "Find Files (Root Dir)" },
      { "<Leader>fF", MyVim.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<Leader>fg", "<Cmd>Telescope git_files<CR>", desc = "Find Files (git-files)" },
      { "<Leader>fr", "<Cmd>Telescope frecency<CR>", desc = "Recent" },
      { "<Leader>fR", "<Cmd>Telescope frecency workspace=CWD<CR>", desc = "Recent (cwd)" },
      -- Git
      { "<Leader>gc", "<Cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<Leader>gs", "<Cmd>Telescope git_status<CR>", desc = "Status" },
      -- Search
      { '<Leader>s"', "<cmd>Telescope registers<CR>", desc = "Registers" },
      { "<Leader>sa", "<Cmd>Telescope autocommands<CR>", desc = "Auto Commands" },
      { "<Leader>sb", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer" },
      { "<Leader>sc", "<Cmd>Telescope command_history<CR>", desc = "Command History" },
      { "<Leader>sC", "<Cmd>Telescope commands<CR>", desc = "Commands" },
      { "<Leader>sd", "<Cmd>Telescope diagnostics bufnr=0<CR>", desc = "Document Diagnostics" },
      { "<Leader>sD", "<Cmd>Telescope diagnostics<CR>", desc = "Workspace Diagnostics" },
      { "<Leader>sg", MyVim.telescope("live_grep"), desc = "Grep (root Dir)" },
      { "<Leader>sG", MyVim.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<Leader>sh", "<Cmd>Telescope help_tags<CR>", desc = "Help Pages" },
      { "<Leader>sH", "<Cmd>Telescope highlights<CR>", desc = "Search Highlight Groups" },
      { "<Leader>sj", "<Cmd>Telescope jumplist<CR>", desc = "Jumplist" },
      { "<Leader>sk", "<Cmd>Telescope keymaps<CR>", desc = "Key Maps" },
      { "<Leader>sl", "<Cmd>Telescope loclist<CR>", desc = "Location List" },
      { "<Leader>sM", "<Cmd>Telescope man_pages<CR>", desc = "Man Pages" },
      { "<Leader>sm", "<Cmd>Telescope marks<CR>", desc = "Jump to Mark" },
      { "<Leader>so", "<Cmd>Telescope vim_options<CR>", desc = "Options" },
      { "<Leader>sq", "<Cmd>Telescope quickfix<CR>", desc = "Quickfix List" },
      { "<Leader>sR", "<Cmd>Telescope resume<CR>", desc = "Resume" },
      { "<Leader>sw", MyVim.telescope("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" },
      { "<Leader>sW", MyVim.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
      { "<Leader>sw", MyVim.telescope("grep_string"), mode = "v", desc = "Selection (Root Dir)" },
      { "<Leader>sW", MyVim.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
      { "<Leader>uC", MyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" },
      {
        "<Leader>ss",
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = require("config").get_kind_filter(),
          })
        end,
        desc = "Goto Symbol",
      },
      {
        "<Leader>sS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = require("config").get_kind_filter(),
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
    opts = function()
      local actions = require("telescope.actions")

      local open_with_trouble = require("trouble.sources.telescope").open
      local find_files_no_ignore = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        MyVim.telescope("find_files", { no_ignore = true, default_text = line })()
      end
      local find_files_with_hidden = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        MyVim.telescope("find_files", { hidden = true, default_text = line })()
      end

      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          -- open files in the first window that is an actual file.
          -- use the current window if no other window is available.
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then
                return win
              end
            end
            return 0
          end,
          mappings = {
            i = {
              ["<M-t>"] = open_with_trouble,
              ["<M-i>"] = find_files_no_ignore,
              ["<M-h>"] = find_files_with_hidden,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-F>"] = actions.preview_scrolling_down,
              ["<C-B>"] = actions.preview_scrolling_up,
            },
            n = {
              ["<M-t>"] = open_with_trouble,
              ["q"] = actions.close,
            },
          },
        },
        extensions = {
          frecency = {
            workspaces = require("config").workspaces,
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
      if not MyVim.has("flash.nvim") then
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
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+Goto" },
        ["z"] = { name = "+Fold" },
        ["]"] = { name = "+Next" },
        ["["] = { name = "+Prev" },
        ["<Leader><Tab>"] = { name = "+Tabs" },
        ["<Leader>b"] = { name = "+Buffer" },
        ["<Leader>c"] = { name = "+Code" },
        ["<Leader>f"] = { name = "+File/Find" },
        ["<Leader>g"] = { name = "+Git" },
        ["<Leader>gh"] = { name = "+Hunks" },
        ["<Leader>q"] = { name = "+Quit/Session" },
        ["<Leader>s"] = { name = "+Search" },
        ["<Leader>T"] = { name = "+Toggle Options" },
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
    event = "LazyFile",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        -- Navigation
        map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")

        -- Actions
        map({ "n", "v" }, "<Leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<Leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<Leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<Leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<Leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<Leader>ghp", gs.preview_hunk_inline, "Preview Hunk")
        map("n", "<Leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<Leader>ghd", gs.diffthis, "Diff This")
        map("n", "<Leader>ghD", function() gs.diffthis("~") end, "Diff This ~")

        -- Toggles
        map("n", "<Leader>Tb", gs.toggle_current_line_blame, "Toggle Current Line [B]lame")
        map("n", "<Leader>TD", gs.toggle_deleted, "Toggle Deleted Git Hunks")

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        -- stylua: ignore end
      end,
    },
  },

  -- Better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<Leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
      {
        "<Leader>xX",
        "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>",
        desc = "Buffer Diagnostics (Trouble)",
      },
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
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },

  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "LazyFile",
    config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment", },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment", },
      { "<Leader>xt", "<Cmd>TodoTrouble<CR>", desc = "Todo (Trouble)" },
      { "<Leader>xT", "<Cmd>TodoTrouble keywords=TODO,FIX,FIXME<CR>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<Leader>st", "<Cmd>TodoTelescope<CR>", desc = "Todo" },
      { "<Leader>sT", "<Cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>", desc = "Todo/Fix/Fixme" },
    },
  },
}
