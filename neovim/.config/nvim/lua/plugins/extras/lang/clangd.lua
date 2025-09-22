return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  {
    "clangd_extensions.nvim",
    optional = true,
    opts = {
      inlay_hints = {
        inline = true,
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
