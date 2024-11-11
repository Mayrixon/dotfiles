return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  {
    "p00f/clangd_extensions.nvim",
    opts = {
      inlay_hints = {
        inline = vim.fn.has("nvim-0.10") == 1,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          keys = {
            { "<leader>ch", false },
            { "<LocalLeader>h", "<Cmd>ClangdSwitchSourceHeader<CR>", desc = "Switch Source/Header (C/C++)" },
          },
        },
      },
    },
  },
  ------------------------------ End modification ------------------------------
}
