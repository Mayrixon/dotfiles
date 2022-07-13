local M = {}

local packer_bootstrap = false

local function packer_init()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd([[packadd packer.nvim]])
  end
  vim.cmd("autocmd BufWritePost plugins.lua source <afile> | PackerCompile")
end

packer_init()

function M.setup()
  local conf = {
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  }

  local function plugins(use)
    -- Development
    use({ "tpope/vim-vinegar" })
    use({ "wellle/targets.vim", event = "BufWinEnter" })
    use({ "rhysd/git-messenger.vim" })
    -- use {
    --   "tanvirtin/vgit.nvim",
    --   event = "BufWinEnter",
    --   config = function()
    --     require("vgit").setup()
    --   end,
    -- }
    use({ "unblevable/quick-scope", event = "VimEnter" })
    use({
      "ruifm/gitlinker.nvim",
      event = "VimEnter",
      config = function()
        require("gitlinker").setup()
      end,
    })

    -- Testing
    use({
      "rcarriga/vim-ultest",
      config = "require('config.test').setup()",
      run = ":UpdateRemotePlugins",
      requires = { "vim-test/vim-test" },
    })

    -- Telescope
    use({
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      as = "telescope",
      requires = {
        "nvim-telescope/telescope-symbols.nvim",
        "nvim-telescope/telescope-media-files.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-github.nvim",
        "fhill2/telescope-ultisnips.nvim",
        "cljoly/telescope-repo.nvim",
        "jvgrootveld/telescope-zoxide",
        "dhruvmanila/telescope-bookmarks.nvim",
        -- 'nvim-telescope/telescope-hop.nvim'
        {
          "nvim-telescope/telescope-arecibo.nvim",
          rocks = { "openssl", "lua-http-parser" },
        },
        {
          "nvim-telescope/telescope-vimspector.nvim",
          event = "BufWinEnter",
        },
        { "nvim-telescope/telescope-dap.nvim" },
      },
      config = function()
        require("config.telescope").setup()
      end,
    })

    -- Project settings
    -- use {'airblade/vim-rooter'}

    -- LSP config
    use({ "jose-elias-alvarez/null-ls.nvim" })
    -- use {
    --   "tamago324/nlsp-settings.nvim",
    --   -- event = "BufReadPre",
    --   config = function()
    --     require("config.nlsp-settings").setup()
    --   end,
    -- }

    -- Completion - use either one of this
    use({ "szw/vim-maximizer", event = "BufWinEnter" })
    use({ "kshenoy/vim-signature", event = "BufWinEnter" })
    use({ "kevinhwang91/nvim-bqf", event = "BufWinEnter" })
    use({ "andymass/vim-matchup", event = "CursorMoved" })
    use({
      "nacro90/numb.nvim",
      event = "VimEnter",
      config = function()
        require("numb").setup()
      end,
    })
    use({ "antoinemadec/FixCursorHold.nvim", event = "BufReadPost" })

    -- Lua development
    use({ "folke/lua-dev.nvim", event = "VimEnter" })
    use({
      "simrat39/symbols-outline.nvim",
      event = "VimEnter",
      config = function()
        require("config.symbols-outline").setup()
      end,
      disable = true, -- TODO: fix
    })

    -- Debugging
    use({ "puremourning/vimspector", event = "InsertEnter" })

    -- DAP
    use({ "mfussenegger/nvim-dap", event = "BufWinEnter", as = "nvim-dap" })
    use({ "mfussenegger/nvim-dap-python", after = "nvim-dap" })
    use({
      "theHamsta/nvim-dap-virtual-text",
      after = "nvim-dap",
      config = function()
        require("nvim-dap-virtual-text").setup({})
      end,
    })
    use({ "rcarriga/nvim-dap-ui", after = "nvim-dap" })
    use({ "Pocco81/DAPInstall.nvim", after = "nvim-dap" })
    use({ "jbyuki/one-small-step-for-vimkind", after = "nvim-dap" })

    -- Development workflow
    use({ "voldikss/vim-browser-search", event = "VimEnter" })
    use({ "tyru/open-browser.vim", event = "VimEnter" })
    use({
      "kkoomen/vim-doge",
      run = ":call doge#install()",
      config = function()
        require("config.doge").setup()
      end,
      event = "VimEnter",
    })
    use({
      "michaelb/sniprun",
      cmd = { "SnipRun" },
      run = "bash install.sh",
      config = function()
        require("config.sniprun").setup()
      end,
    })

    -- Rust
    use({ "rust-lang/rust.vim", event = "VimEnter" })
    use({
      "Saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      config = function()
        require("crates").setup()
      end,
    })

    -- Note taking
    -- use {
    --   "nvim-neorg/neorg",
    --   event = "VimEnter",
    --   config = function()
    --     require("config.neorg").setup()
    --   end,
    -- }
    use({
      "stevearc/gkeep.nvim",
      run = ":UpdateRemotePlugins",
    })

    use({ "rhysd/vim-grammarous", ft = { "markdown" } })

    use({
      "folke/zen-mode.nvim",
      event = "VimEnter",
      cmd = "ZenMode",
      config = function()
        require("zen-mode").setup({})
      end,
    })
    use({
      "folke/twilight.nvim",
      event = "VimEnter",
      config = function()
        require("twilight").setup({})
      end,
    })

    -- Database
    use({
      "tpope/vim-dadbod",
      event = "VimEnter",
      requires = { "kristijanhusak/vim-dadbod-ui", "kristijanhusak/vim-dadbod-completion" },
      config = function()
        require("config.dadbod").setup()
      end,
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

    -- AI completion
    use({ "github/copilot.vim" })

    -- Notifications
    use({
      "rcarriga/nvim-notify",
      config = function()
        vim.notify = require("notify")
      end,
    })

    -- Better configuration
    use({ "nathom/filetype.nvim" })

    -- Clipboard
    use({
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("neoclip").setup()
      end,
    })

    -- Trying

    -- To try
    -- https://github.com/mfussenegger/nvim-lint

    use({
      "akinsho/toggleterm.nvim",
      keys = { [[<c-\>]] },
      cmd = { "ToggleTerm", "TermExec" },
      config = function()
        require("config.toggleterm").setup()
      end,
    })

    use({ "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } })
    -- use {
    --   "LinArcX/telescope-command-palette.nvim",
    --   after = "telescope",
    --   config = function()
    --     require("config.command-palette").setup()
    --   end,
    -- }
    -- use {
    --   "pianocomposer321/yabs.nvim",
    --   after = "telescope",
    --   requires = { "nvim-lua/plenary.nvim", "pianocomposer321/consolation.nvim" },
    --   config = function()
    --     require("config.yabs").setup()
    --   end,
    -- }

    use({ "b0o/schemastore.nvim" })
    use({
      "ThePrimeagen/harpoon",
      -- event = "VimEnter",
      module = "harpoon",
      config = function()
        require("config.harpoon").setup()
      end,
    })
    use({ "chaoren/vim-wordmotion", opt = true, fn = { "<Plug>WordMotion_w" } })

    -- Legendary
    use({
      "mrjones2014/legendary.nvim",
      keys = { [[<C-p>]] },
      config = function()
        require("config.legendary").setup()
      end,
      requires = { "stevearc/dressing.nvim" },
    })

    use({
      "j-hui/fidget.nvim",
      event = "BufReadPre",
      config = function()
        require("fidget").setup({})
      end,
    })
    -- use {
    --   "hoschi/yode-nvim",
    --   cmd = { "YodeCreateSeditorFloating", "YodeFloatToMainWindow", "YodeCloneCurrentIntoFloat" },
    --   config = function()
    --     require("yode-nvim").setup {}
    --   end,
    -- }
    -- use {
    --   "rlch/github-notifications.nvim",
    --   config = [[require('config.github-notifications').setup()]],
    -- }
    -- use {
    --   "danymat/neogen",
    --   config = function()
    --     require("neogen").setup {
    --       enabled = true,
    --     }
    --   end,
    --   requires = "nvim-treesitter/nvim-treesitter",
    -- }
    -- use {
    --   "winston0410/range-highlight.nvim",
    --   requires = { { "winston0410/cmd-parser.nvim" } },
    --   config = function()
    --     require("range-highlight").setup {}
    --   end,
    -- }

    -- use {
    --   "sidebar-nvim/sidebar.nvim",
    --   config = function()
    --     require("sidebar-nvim").setup { open = false }
    --   end,
    -- }
    -- use {
    --   "ldelossa/litee.nvim",
    --   config = function()
    --     require("litee").setup {}
    --   end,
    -- }
    -- use {
    --   "luukvbaal/stabilize.nvim",
    --   config = function()
    --     require("stabilize").setup()
    --   end,
    -- }
    -- use { "skywind3000/vim-quickui" }
    -- use {
    --   "ThePrimeagen/refactoring.nvim",
    --   event = "VimEnter",
    --   config = function()
    --     require("config.refactoring").setup()
    --   end,
    -- }
    -- use {
    --   "mvllow/modes.nvim",
    --   event = "BufRead",
    --   config = function()
    --     vim.opt.cursorline = true
    --     require("modes").setup()
    --   end,
    -- }
    -- use {
    --   "jbyuki/venn.nvim",
    --   event = "VimEnter",
    --   config = function()
    --     vim.api.nvim_set_keymap("v", "<Leader>vb", ":VBox<CR>", { noremap = true })
    --   end,
    -- }
    -- use {
    --   "voldikss/vim-translator",
    --   event = "VimEnter",
    --   setup = function()
    --     vim.g.translator_history_enable = true
    --   end,
    -- }

    -- use {"haringsrob/nvim_context_vt"}

    -- LIST of plugins
    -- https://gist.github.com/mengwangk/dc703fb091e25dd75b7ef7c7be3bd4c9

    if packer_bootstrap then
      print("Setting up Neovim. Restart required after installation!")
      require("packer").sync()
    end
  end

  pcall(require, "impatient")
  pcall(require, "packer_compiled")
  require("packer").init(conf)
  require("packer").startup(plugins)
end

return M
