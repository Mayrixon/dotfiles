return {
  -- Add Obj-C/Swift to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "objc", "swift" })
      end
    end,
  },

  -- Correctly setup lspconfig for sourcekit 🚀
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        sourcekit = {
          filetypes = { "swift", "objective-c", "objective-cpp" },
        },
      },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.swiftlint,
        nls.builtins.formatting.swift_format,
        nls.builtins.formatting.swiftformat,
      })
    end,
  },
}
