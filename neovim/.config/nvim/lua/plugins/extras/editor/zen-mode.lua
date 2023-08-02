return {
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    keys = {
      { "<Leader>uz", "<Cmd>ZenMode<CR>", desc = "Zen Mode" },
    },
    opts = {
      plugins = {
        twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = true }, -- disables git signs
        tmux = { enabled = true }, -- disables the tmux statusline
        -- this will change the font size on alacritty when in zen mode
        -- requires  Alacritty Version 0.10.0 or higher
        -- uses `alacritty msg` subcommand to change font size
        -- TODO: decide after test.
        alacritty = {
          enabled = false,
          font = "14", -- font size
        },
        -- this will change the font size on wezterm when in zen mode
        -- See alse also the Plugins/Wezterm section in this projects README
        -- TODO: decide after test.
        wezterm = {
          enabled = false,
          -- can be either an absolute font size or the number of incremental steps
          font = "+4", -- (10% increase per step)
        },
      },
      on_open = function(_)
        vim.opt_local.scrolloff = 999
        vim.opt_local.wrap = true

        vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
        vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

        vim.cmd("DisableWhitespace")
      end,
      on_close = function()
        vim.opt_local.scrolloff = -1
        vim.opt_local.wrap = vim.opt.wrap:get()

        vim.keymap.del({ "n", "x" }, "j")
        vim.keymap.del({ "n", "x" }, "k")

        vim.cmd("EnableWhitespace")
      end,
    },
  },

  {
    "folke/twilight.nvim",
    event = "VeryLazy",
    keys = {
      { "<Leader>uh", "<Cmd>Twilight<CR>", desc = "Toggle zen-mode highlight" },
    },
    opts = {
      dimming = {
        inactive = true,
      },
    },
  },
}
