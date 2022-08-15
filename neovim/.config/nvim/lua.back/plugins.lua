local M = {}

function M.setup()
  local function plugins(use)
    -- Development
    use({ "tpope/vim-vinegar" })
    use({ "rhysd/git-messenger.vim" })
    -- use {
    --   "tanvirtin/vgit.nvim",
    --   event = "BufWinEnter",
    --   config = function()
    --     require("vgit").setup()
    --   end,
    -- }

    use({ "antoinemadec/FixCursorHold.nvim", event = "BufReadPost" })

    -- Debug tools
    use({
      "puremourning/vimspector",
      event = "InsertEnter",
      setup = [[vim.g.vimspector_enable_mappings = 'HUMAN']],
      disable = true,
    })
    -- "nvim-telescope/telescope-vimspector.nvim",

    -- DAP
    use({
      {
        "mfussenegger/nvim-dap",
        setup = [[require('config.dap_setup')]],
        config = [[require('config.dap')]],
        requires = "jbyuki/one-small-step-for-vimkind",
        wants = "one-small-step-for-vimkind",
        module = "dap",
        -- event="BufWinEnter"
      },
      {
        "rcarriga/nvim-dap-ui",
        requires = "nvim-dap",
        after = "nvim-dap",
        config = function()
          require("dapui").setup()
        end,
      },
    })
    use({ "mfussenegger/nvim-dap-python", after = "nvim-dap" })
    use({
      "theHamsta/nvim-dap-virtual-text",
      after = "nvim-dap",
      config = function()
        require("nvim-dap-virtual-text").setup({})
      end,
    })
    use({ "Pocco81/DAPInstall.nvim", after = "nvim-dap", branch = "dev" })
    -- use({ "jbyuki/one-small-step-for-vimkind", after = "nvim-dap" })
    use({ "nvim-telescope/telescope-dap.nvim" })

    -- Test tools
    -- TODO: use https://github.com/nvim-neotest/neotest instead of this deprecated plugin.
    use({
      "rcarriga/vim-ultest",
      config = function()
        require("config.test").setup()
      end,
      run = ":UpdateRemotePlugins",
      requires = { "vim-test/vim-test" },
    })

    -- Web
    use({
      "vuki656/package-info.nvim",
      event = "VimEnter",
      requires = "MunifTanjim/nui.nvim",
      config = function()
        require("package-info").setup()
      end,
    })

    use({ { "nvim-orgmode/orgmode.nvim", config = [[require('config.orgmode')]] }, "akinsho/org-bullets.nvim" })
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
    -- LIST of plugins
    -- https://gist.github.com/mengwangk/dc703fb091e25dd75b7ef7c7be3bd4c9
  end
end

return M
