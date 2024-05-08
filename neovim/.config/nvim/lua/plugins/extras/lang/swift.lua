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
          filetypes = { "swift", "objc", "objcpp" },
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        objc = { "swiftlint" },
        objcpp = { "swiftlint" },
        swift = { "swiftlint" },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = { swift = { { "swiftformat", "swift_format" } } },
    },
  },
}
