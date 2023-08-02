return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    ft = "markdown",
    keys = {
      { "<LocalLeader>p", "<Cmd>MarkdownPreviewToggle<CR>", desc = "Preview" },
    },
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
  {
    -- INFO: the default config requiring a font containing 🬂(U+1FB02).
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter",
    config = true,
  },

  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<LocalLeader>l"] = { name = "+mkdx" },
      },
    },
  },
  {
    "SidOfc/mkdx",
    ft = { "markdown", "rmd" },
    config = function()
      vim.g["mkdx#settings"] = {
        highlight = { enable = 1 },
        enter = { shift = 1 },
        links = { external = { enable = 1 } },
        map = { prefix = "<localleader>l", enable = 1 },
        toc = { update_on_write = 1 },
        fold = { enable = 1 },
      }

      -- Add shortcut to add wikilinks
      vim.keymap.set("n", "<LocalLeader>lw", function()
        vim.fn["mkdx#WrapText"]("n", "[[", "]]")
      end, { desc = "Add Wiki Link to Current Word", buffer = true })
      vim.keymap.set(
        "v",
        "<LocalLeader>lw",
        ':call mkdx#WrapText("v", "[[", "]]")<CR>',
        { desc = "Add Wiki Link", buffer = true }
      )
    end,
  },
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    ft = "markdown",
    keys = {
      { "<LocalLeader>g", "<Cmd>Glow<CR>", desc = "Glow Preview" },
    },
    config = true,
  },
}
