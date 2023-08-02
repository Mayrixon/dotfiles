return {
  -- Measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- Session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "globals", "help", "skiprtp", "tabpages", "winsize" } },
    keys = {
      {
        "<Leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore Session",
      },
      {
        "<Leader>ql",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore Last Session",
      },
      {
        "<Leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
  },

  -- Linters, formatters, and LSP/DAP servers
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    event = "BufReadPre",
    -- TODO: may remap to Leader-z
    keys = { { "<Leader>cm", "<Cmd>Mason<CR>", desc = "Mason" } },
    opts = {
      PATH = "append",
      ensure_installed = {
        -- LSP servers
        -- "lua-language-server",
        -- "vim-language-server",
        -- "marksman",
        -- Formatters
        "stylua",
        "shfmt",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  -- Auto set buffer indent
  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
    keys = {
      { "<Leader>uS", "<Cmd>Sleuth<CR>", desc = "Sleuth" },
    },
  },
}
