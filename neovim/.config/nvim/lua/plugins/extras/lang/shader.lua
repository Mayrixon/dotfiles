return {
  -- Add wgsl to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "glsl", "wgsl", "wgsl_bevy" })
      end

      vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = "*.wgsl",
        callback = function()
          vim.opt_local.filetype = "wgsl"
        end,
      })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        glsl = { "glslc" },
      },
    },
  },

  -- Correctly setup lspconfig for wgsl 🚀
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        glslls = {},
        wgsl_analyzer = {},
      },
    },
  },
}
