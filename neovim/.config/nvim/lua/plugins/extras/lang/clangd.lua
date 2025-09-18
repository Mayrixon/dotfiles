return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  {
    "clangd_extensions.nvim",
    optional = true,
    opts = {
      inlay_hints = {
        inline = vim.fn.has("nvim-0.10") == 1,
      },
    },
  },

  {
    "nvim-lspconfig",
    optional = true,
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
