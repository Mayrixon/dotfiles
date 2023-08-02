return {
  -- gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    -- priority = 1000,
    opts = {
      -- overrides = {
      --   LspReferenceText = lsp_highlight_color,
      --   LspReferenceWrite = lsp_highlight_color,
      --   LspReferenceRead = lsp_highlight_color,
    },
  },

  -- tokyonight
  {
    "folke/tokyonight.nvim",
    version = "*",
    lazy = true,
  },

  -- catppuccin
  {
    "catppuccin/nvim",
    version = "*",
    lazy = true,
    name = "catppuccin",
    opts = {
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },

  -- kanagawa
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
}
