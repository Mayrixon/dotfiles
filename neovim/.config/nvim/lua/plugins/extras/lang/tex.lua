return {

  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<LocalLeader>l"] = { name = "+vimtex" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        bib = { "bibtex-tidy" },
        tex = { "latexindent" },
      },
      formatters = { latexindent = { prepend_args = { "-m", "-l" } } },
    },
  },

  -- Add BibTeX/LaTeX to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "bibtex", "latex" })
      end
      if type(opts.highlight.disable) == "table" then
        vim.list_extend(opts.highlight.disable, { "latex" })
      else
        opts.highlight.disable = { "latex" }
      end
    end,
  },

  {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    config = function()
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = vim.api.nvim_create_augroup("lazyvim_vimtex_conceal", { clear = true }),
        pattern = { "bib", "tex" },
        callback = function()
          vim.wo.conceallevel = 2
        end,
      })

      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = vim.api.nvim_create_augroup("lazyvim_vimtex_keymap", { clear = true }),
        pattern = { "bib", "tex" },
        callback = function()
          vim.keymap.set("n", "<LocalLeader>ld", "<plug>(vimtex-doc-package)", { silent = true })
        end,
      })

      vim.g.vimtex_compiler_latexmk = {
        ["options"] = {
          "-shell-escape",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
      vim.g.vimtex_complete_enabled = 0 -- use texlab for completion
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"

      vim.g.vimtex_view_method = vim.fn.has("mac") == 1 and "skim" or "zathura"
    end,
  },

  -- Correctly setup lspconfig for LaTeX 🚀
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        texlab = {},
      },
    },
  },
}
