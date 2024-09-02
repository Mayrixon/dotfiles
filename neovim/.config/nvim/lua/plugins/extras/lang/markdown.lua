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
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        markdown = function(bufnr)
          local prettier = ""
          if require("conform").get_formatter_info("prettierd", bufnr).available then
            prettier = "prettierd"
          else
            prettier = "prettier"
          end
          return { prettier, "markdownlint", "mdslw" }
        end,
        ["markdown.mdx"] = function(bufnr)
          local prettier = ""
          if require("conform").get_formatter_info("prettierd", bufnr).available then
            prettier = "prettierd"
          else
            prettier = "prettier"
          end
          return { prettier, "markdownlint", "mdslw" }
        end,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "markdownlint", "marksman", "mdformat", "mdslw" })
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    keys = {
      { "<Leader>cp", false },
      {
        "<LocalLeader>p",
        ft = "markdown",
        "<Cmd>MarkdownPreviewToggle<CR>",
        desc = "Markdown Preview",
      },
    },
  },

  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<LocalLeader>l", group = "mkdx" },
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
