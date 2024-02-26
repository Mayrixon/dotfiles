return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "commonlisp", "scheme", "racket" })
      end
    end,
  },
  {
    "eraserhd/parinfer-rust",
    build = "cargo build --release",
    ft = { "lisp", "scheme", "racket" },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        racket_langserver = {},
      },
    },
  },
}
