return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  -- tokyonight
  { "tokyonight.nvim", opts = {
    transparent = true,
  } },

  -- catppuccin
  {
    "catppuccin",
    opts = {
      transparent_background = true,
    },
  },
  ------------------------------ End modification ------------------------------

  -- gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      transparent_mode = true,
      overrides = {
        NotifyBackground = { bg = "#000000" },
      },
    },
  },
}
