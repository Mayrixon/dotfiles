local icons = require("lazyvim.config").icons

return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  {
    "neo-tree.nvim",
    opts = {
      window = {
        mappings = {
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
          ["w"] = "none",
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
        { "<Leader><Tab>", group = "Tabs" },
        { "<Leader>T", group = "Toggle Options", icon = { icon = "󰙵 ", color = "cyan" } },
        { "<Leader>c", group = "Code" },
        { "<Leader>f", group = "File/Find" },
        { "<Leader>g", group = "Git" },
        { "<Leader>gh", group = "Hunks" },
        { "<Leader>q", group = "Quit/Session" },
        { "<Leader>s", group = "Search" },
        { "<Leader>u", group = "Utilities" },
        { "<Leader>x", group = "Diagnostics/Quickfix", icon = { icon = "󱖫 ", color = "green" } },
        { "[", group = "Prev" },
        { "]", group = "Next" },
        { "g", group = "Goto" },
        { "gs", group = "Surround" },
        { "z", group = "Fold" },
        {
          "<Leader>b",
          group = "Buffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        {
          "<Leader>w",
          group = "Windows",
          proxy = "<C-W>",
          expand = function()
            return require("which-key.extras").expand.win()
          end,
        },
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
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
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
        Snacks.toggle({
          name = "Current Line [B]lame",
          get = function()
            return require("gitsigns.config").config.current_line_blame
          end,
          set = function(state)
            gs.toggle_current_line_blame(state)
          end,
        }):map("<Leader>Tb")
        Snacks.toggle({
          name = "Deleted Git Hunks",
          get = function()
            return require("gitsigns.config").config.show_deleted
          end,
          set = function(state)
            gs.toggle_deleted(state)
          end,
        }):map("<Leader>TD")

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
  ------------------------------ End modification ------------------------------
}
