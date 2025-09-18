return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "matlab" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {},
    servers = {
      matlab_ls = {
        -- cmd = { "matlab", "-r", "matlab_language_server" },
        -- filetypes = { "matlab" },
        -- root_dir = function(fname)
        --   return vim.fn.getcwd()
        -- end,
      },
    },
  },
  -- { "mfussenegger/nvim-lint", opts = {
  --   linters_by_ft = {
  --     matlab = { "mlint" },
  --   },
  -- } },
}
