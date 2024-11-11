return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  {
    "vimtex",
    config = function()
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"

      vim.g.vimtex_compiler_latexmk = {
        ["options"] = {
          "-shell-escape",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }

      -- vim.g.vimtex_complete_enabled = 0 -- use texlab for completion
      vim.g.vimtex_view_method = vim.fn.has("mac") == 1 and "skim" or "zathura"
    end,
  },
  ------------------------------ End modification ------------------------------

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
}
