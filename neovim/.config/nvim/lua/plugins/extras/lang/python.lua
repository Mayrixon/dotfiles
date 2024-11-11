return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          keys = {
            { "<Leader>co", false },
            {
              "<LocalLeader>o",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
        },
        ruff_lsp = {
          keys = {
            { "<Leader>co", false },
            {
              "<LocalLeader>o",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
          },
        },
      },
    },
  },
  {
    "venv-selector.nvim",
    keys = {
      { "<Leader>cv", false },
      { "<LocalLeader>v", "<Cmd>VenvSelect<CR>", desc = "Select VirtualEnv", ft = "python" },
    },
  },
  ------------------------------ End modification ------------------------------
}
