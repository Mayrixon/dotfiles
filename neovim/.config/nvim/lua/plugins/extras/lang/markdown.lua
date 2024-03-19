return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "markdownlint", "marksman" })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.diagnostics.markdownlint,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    keys = {
      {
        "<LocalLeader>p",
        ft = "markdown",
        "<Cmd>MarkdownPreviewToggle<CR>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },

  {
    -- INFO: the default config requiring a font containing 🬂(U+1FB02).
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter",
    opts = function()
      local opts = {}
      for _, ft in ipairs({ "markdown", "norg", "rmd", "org" }) do
        opts[ft] = {
          headline_highlights = {},
          -- disable bullets for now. See https://github.com/lukas-reineke/headlines.nvim/issues/66
          bullets = {},
        }
        for i = 1, 6 do
          local hl = "Headline" .. i
          vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
          table.insert(opts[ft].headline_highlights, hl)
        end
      end
      return opts
    end,
    ft = { "markdown", "norg", "rmd", "org" },
    config = function(_, opts)
      -- PERF: schedule to prevent headlines slowing down opening a file
      vim.schedule(function()
        require("headlines").setup(opts)
        require("headlines").refresh()
      end)
    end,
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
