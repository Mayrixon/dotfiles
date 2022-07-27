local function startup()
  local packer = require("packer")

  packer.init({ max_jobs = 20 })

  packer.startup({
    config = { profile = { enable = true } },
    function(use)
      -- Testing
      -- TODO: use https://github.com/nvim-neotest/neotest instead of this deprecated plugin.
      use({
        "rcarriga/vim-ultest",
        config = function()
          require("config.test").setup()
        end,
        run = ":UpdateRemotePlugins",
        requires = { "vim-test/vim-test" },
      })

      ---- DAP
      use({ "mfussenegger/nvim-dap" })
      use({ "Pocco81/DAPInstall.nvim", branch = "dev" })
      use({ "rcarriga/nvim-dap-ui" })
      use({ "theHamsta/nvim-dap-virtual-text" })
      use({ "nvim-telescope/telescope-dap.nvim" })
      use({ "jbyuki/one-small-step-for-vimkind" })

      -- Embed in browser
      -- use {'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
    end,
  })
end

--------------------------------- Plugin Lists ---------------------------------
-- use {'wellle/targets.vim'}

-- use {'chrisbra/NrrwRgn'}

-- use {'jiangmiao/auto-pairs'}

-- use {'unblevable/quick-scope'}
-- use {'phaazon/hop.nvim', as = 'hop'}

-- Lua config enhancement
-- use {'tjdevries/astronauta.nvim'}

-- Treesitter
-- use {'mfussenegger/nvim-ts-hint-textobject'}
-- use {'RRethy/nvim-treesitter-textsubjects'}

-- use {
--   'nvim-neorg/neorg',
--   config = function() require('config.neorg').setup() end,
--   requires = {'nvim-lua/plenary.nvim', {'nvim-neorg/neorg-telescope'}}
-- }
-- use {
--   'kristijanhusak/orgmode.nvim',
--   branch = 'tree-sitter',
--   config = function()
--     require('orgmode').setup {org_default_notes_file = '~/org'}
--   end
-- }
