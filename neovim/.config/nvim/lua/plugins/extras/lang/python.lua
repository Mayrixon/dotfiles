if myvim_docs then
  -- LSP Server to use for Python.
  -- Set to "basedpyright" to use basedpyright instead of pyright.
  vim.g.myvim_python_lsp = "pyright"
  vim.g.myvim_python_ruff = "ruff_lsp"
end

local lsp = vim.g.myvim_python_lsp or "pyright"
local ruff = vim.g.myvim_python_ruff or "ruff_lsp"

return {
  {
    "nvim-treesitter/nvim-treesitter",
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
        pyright = {
          enabled = lsp == "pyright",
        },
        basedpyright = {
          enabled = lsp == "basedpyright",
        },
        [lsp] = {
          enabled = true,
        },
        ruff_lsp = {
          enabled = ruff == "ruff_lsp",
        },
        ruff = {
          enabled = ruff == "ruff",
        },
        [ruff] = {
          keys = {
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
      setup = {
        [ruff] = function()
          MyVim.lsp.on_attach(function(client, _)
            if client.name == ruff then
              -- Disable hover in favor of Pyright
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
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
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mfussenegger/nvim-dap-python",
      -- stylua: ignore
      keys = {
        { "<Leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
        { "<Leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
      },
      config = function()
        require("dap-python").setup(MyVim.get_pkg_path("debugpy", "/venv/bin/python"))
      end,
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    cmd = "VenvSelect",
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    },
    --  Call config for python files and load the cached venv automatically
    ft = "python",
    keys = { { "<LocalLeader>v", "<Cmd>VenvSelect<CR>", desc = "Select VirtualEnv", ft = "python" } },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.auto_brackets = opts.auto_brackets or {}
      table.insert(opts.auto_brackets, "python")
    end,
  },
}
