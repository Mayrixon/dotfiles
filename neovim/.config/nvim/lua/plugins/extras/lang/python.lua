if lazyvim_docs then
  -- LSP Server to use for Python.
  -- Set to "basedpyright" to use basedpyright instead of pyright.
  vim.g.lazyvim_python_lsp = "pyright"
  vim.g.lazyvim_python_ruff = "ruff_lsp"
end

local lsp = vim.g.lazyvim_python_lsp or "pyright"
local ruff = vim.g.lazyvim_python_ruff or "ruff_lsp"

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        [ruff] = {
          keys = {
            { "<Leader>co", false },
            {
              "<LocalLeader>o",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.organizeImports" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Organize Imports",
            },
          },
        },
      },
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    keys = {
      { "<Leader>cv", false },
      { "<LocalLeader>v", "<Cmd>VenvSelect<CR>", desc = "Select VirtualEnv", ft = "python" },
    },
  },
}
