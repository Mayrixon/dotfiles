local icons = require("lazyvim.config").icons

return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  {
    "neo-tree.nvim",
    opts = {
      window = {
        mappings = {
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
      },
    },
  },

  {
    "telescope.nvim",
    opts = function()
      local actions = require("telescope.actions")

      local open_with_trouble = require("trouble.sources.telescope").open
      local find_files_no_ignore = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        LazyVim.telescope("find_files", { no_ignore = true, default_text = line })()
      end
      local find_files_with_hidden = function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        LazyVim.telescope("find_files", { hidden = true, default_text = line })()
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
      }
    end,
  },

  {
    "flash.nvim",
    opts = { modes = { search = { enabled = false } } },
    -- stylua: ignore
    keys = {
      { "s", false },
      { "S", false },
      { "gz", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "gZ", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  {
    "which-key.nvim",
    opts = {
      defaults = {},
      spec = {
        mode = { "n", "v" },
        { "g", group = "Goto" },
        { "z", group = "Fold" },
        { "]", group = "Next" },
        { "[", group = "Prev" },
        { "<Leader><Tab>", group = "Tabs" },
        { "<Leader>b", group = "Buffer" },
        { "<Leader>c", group = "Code" },
        { "<Leader>f", group = "File/Find" },
        { "<Leader>g", group = "Git" },
        { "<Leader>gh", group = "Hunks" },
        { "<Leader>q", group = "Quit/Session" },
        { "<Leader>s", group = "Search" },
        { "<Leader>T", group = "Toggle Options" },
        { "<Leader>u", group = "Utilities" },
        { "<Leader>w", group = "Windows" },
        { "<Leader>x", group = "Diagnostics/Quickfix" },
      },
    },
  },

  {
    "gitsigns.nvim",
    opts = {
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
  ------------------------------ End modification ------------------------------
}
