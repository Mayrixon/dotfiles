return {
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        ruff_lsp = {},
      },
    },
    setup = {
      ruff_lsp = function()
        require("util").on_attach(function(client, _)
          if client.name == "ruff_lsp" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end)
      end,
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },
  },

  -- Ensure Python debugger is installed
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "debugpy" })
      end
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mfussenegger/nvim-dap-python",
      -- stylua: ignore
      keys = {
        { "<Leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method" },
        { "<Leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class" },
      },
      config = function()
        local path = require("mason-registry").get_package("debugpy"):get_install_path()
        require("dap-python").setup(path .. "/venv/bin/python")
      end,
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    cmd = "VenvSelect",
    opts = {},
    config = function(_, opts)
      require("venv-selector").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.keymap.set("n", "<LocalLeader>v", function()
            vim.cmd("VenvSelect")
          end, { desc = "Select VirtualEnv", buffer = true })
        end,
      })
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      vim.list_extend(opts.sources, {
        nls.builtins.formatting.isort,
        nls.builtins.formatting.black,
      })
    end,
  },
}
