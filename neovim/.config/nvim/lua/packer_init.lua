-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PackerBootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.o.runtimepath = vim.fn.stdpath("data") .. "/site/pack/*/start/*," .. vim.o.runtimepath
end

-- Autocommand that reloads neovim after edit this file.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init({ max_jobs = 20 })
vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
  use({ "wbthomason/packer.nvim" })

  -- Faster startup
  use({ "lewis6991/impatient.nvim" })
  use({ "nathom/filetype.nvim" })

  -- General
  use({ "tpope/vim-sleuth" })
  use({ "voldikss/vim-floaterm", event = "VimEnter" })
  use({
    "liuchengxu/vista.vim",
    config = function()
      require("plugins.vista").setup()
    end,
  })

  -- -- Async building & commands
  use({ "tpope/vim-dispatch", cmd = { "Dispatch", "Make", "Focus", "Start" } })

  -- -- Cheatsheet
  use({
    "sudormrfbin/cheatsheet.nvim",
    cmd = "Cheatsheet",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  })

  -- -- Colorscheme
  use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })

  -- -- Dashboard
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").opts)
    end,
  })

  -- -- File explorer
  use({
    "nvim-tree/nvim-tree.lua",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
      "NvimTreeFocus",
    },
    config = function()
      require("plugins.nvim-tree").setup()
    end,
  })

  -- -- Key hints
  use({
    { "folke/which-key.nvim" },
    { "junegunn/vim-peekaboo" },
  })

  -- -- Status line
  use({
    {
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
    },
    {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig",
    },
    { "nanozuki/tabby.nvim" },
    {
      "j-hui/fidget.nvim",
      event = "BufReadPre",
      config = function()
        require("fidget").setup()
      end,
    },
  })

  -- -- Render
  use({
    {
      "norcalli/nvim-colorizer.lua",
      event = "BufWinEnter",
      config = function()
        require("colorizer").setup({
          "*",
          "!packer",
        })
      end,
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      requires = "nvim-treesitter/nvim-treesitter",
      config = function()
        require("indent_blankline").setup({
          show_current_context = true,
          use_treesitter = true,
        })
      end,
    },
    {
      "ntpeters/vim-better-whitespace",
      config = function()
        require("plugins.whitespace").setup()
      end,
    },
    {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      event = "VimEnter",
      config = function()
        require("todo-comments").setup({})
      end,
    },
  })

  -- -- UI improvements
  use({ "stevearc/dressing.nvim", event = "BufWinEnter" })

  -- -- Zen mode
  use({
    {
      "folke/zen-mode.nvim",
      config = function()
        require("plugins.zen-mode").setup()
      end,
    },
    {
      "folke/twilight.nvim",
      config = function()
        require("twilight").setup({ context = 20 })
      end,
    },
  })

  -- Edit
  use({
    { "junegunn/vim-easy-align", event = "BufReadPost" },
    { "easymotion/vim-easymotion" },
    -- { "tpope/vim-unimpaired" },
    { "tpope/vim-surround", event = "BufRead" },
    {
      "numToStr/Comment.nvim",
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("Comment").setup()
      end,
    },
    {
      "mbbill/undotree",
      cmd = "UndotreeToggle",
      config = function()
        require("plugins.undotree").setup()
      end,
    },
    {
      "windwp/nvim-autopairs",
      run = "make",
      config = function()
        require("plugins.nvim-autopairs").setup()
      end,
    },
  })
  use({ "kevinhwang91/nvim-bqf", event = "BufWinEnter" })

  -- -- Completion
  use({
    {
      "hrsh7th/nvim-cmp",
      requires = {
        "onsails/lspkind-nvim",
        "lukas-reineke/cmp-under-comparator",
      },
      event = "InsertEnter *",
      config = function()
        require("plugins.cmp").setup()
      end,
    },
    { "hrsh7th/cmp-nvim-lsp", requires = "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
    { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
    { "hrsh7th/cmp-path", after = "nvim-cmp" },
    { "hrsh7th/cmp-calc", after = "nvim-cmp" },
    { "hrsh7th/cmp-emoji", after = "nvim-cmp" },
    { "f3fora/cmp-spell", after = "nvim-cmp" },
    { "ray-x/cmp-treesitter", after = "nvim-cmp", requires = "nvim-treesitter/nvim-treesitter" },
    { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp", requires = "L3MON4D3/LuaSnip" },
    { "octaltree/cmp-look", after = "nvim-cmp" },
    { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" },
  })

  -- -- Document generation
  use({
    "danymat/neogen",
    config = function()
      require("neogen").setup({ snippet_engine = "luasnip" })
    end,
    requires = { "nvim-treesitter/nvim-treesitter", "L3MON4D3/LuaSnip" },
  })

  -- -- Formatter
  use({
    "mhartington/formatter.nvim",
    config = function()
      require("plugins.formatter").setup()
    end,
  })

  -- -- Linter
  use({
    "mfussenegger/nvim-lint",
    config = function()
      require("plugins.lint").setup()
    end,
  })
  -- -- Snippets
  use({
    "L3MON4D3/LuaSnip",
    event = "VimEnter",
    config = function()
      require("plugins.luasnip").setup()
    end,
  })
  use({ "rafamadriz/friendly-snippets" })

  -- Development
  -- -- REPLs
  use({
    "michaelb/sniprun",
    cmd = { "SnipRun" },
    run = "bash install.sh",
    config = function()
      require("plugins.sniprun").setup()
    end,
  })

  -- Git
  use({
    { "tpope/vim-fugitive", event = "BufRead", cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" } },
    { "tpope/vim-rhubarb" },
    { "junegunn/gv.vim" },
    {
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      event = "BufReadPre",
      config = function()
        require("plugins.gitsigns").setup()
      end,
    },
    {
      "sindrets/diffview.nvim",
      requires = "nvim-lua/plenary.nvim",
      cmd = {
        "DiffviewOpen",
        "DiffviewClose",
        "DiffviewToggleFiles",
        "DiffviewFocusFiles",
      },
    },
    {
      "TimUntersberger/neogit",
      requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
      cmd = "Neogit",
      config = function()
        require("neogit").setup({ integrations = { diffview = true } })
      end,
    },
  })

  -- LSP
  use({
    { "neovim/nvim-lspconfig" },
    { "onsails/lspkind-nvim" },
    { "ray-x/lsp_signature.nvim" },
    {
      "RRethy/vim-illuminate",
      config = function()
        require("plugins.illuminate").setup()
      end,
    },
    {
      "rmagatti/goto-preview",
      event = "BufWinEnter",
    },
  })

  -- Search
  use({
    {
      "kevinhwang91/nvim-hlslens",
      config = function()
        require("plugins.hlslens").setup()
      end,
    },
    { "windwp/nvim-spectre" },
    { "voldikss/vim-browser-search" },
    {
      "folke/trouble.nvim",
      event = "VimEnter",
      config = function()
        require("trouble").setup({})
      end,
    },
  })
  use({ "dbeniamine/cheat.sh-vim" })

  -- -- Telescope
  use({
    {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
      },
      cmd = "Telescope",
      config = function()
        require("plugins.telescope").setup()
      end,
    },
    {
      "nvim-telescope/telescope-frecency.nvim",
      requires = {
        "tami5/sqlite.lua",
        { "kyazdani42/nvim-web-devicons", opt = true },
      },
    },
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    {
      "nvim-telescope/telescope-project.nvim",
      requires = {
        "ahmedkhalf/project.nvim",
        -- event = "VimEnter",
        config = function()
          require("project_nvim").setup({ show_hidden = true })
        end,
      },
    },
    { "nvim-telescope/telescope-symbols.nvim" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "TC72/telescope-tele-tabby.nvim" },
    { "nvim-telescope/telescope-packer.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    {
      "rmagatti/session-lens",
      requires = {
        {
          "rmagatti/auto-session",
          config = function()
            require("plugins.auto-session").setup()
          end,
        },
        "nvim-telescope/telescope.nvim",
      },
      event = "VimEnter",
      config = function()
        require("session-lens").setup({})
      end,
    },
  })

  -- Treesitter
  use({
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      event = "BufRead",
      config = function()
        require("plugins.treesitter").setup()
      end,
    },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "p00f/nvim-ts-rainbow" },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    { "romgrk/nvim-treesitter-context" },
    { "windwp/nvim-ts-autotag" },
    {
      "lewis6991/spellsitter.nvim",
      config = function()
        require("spellsitter").setup()
      end,
    },
  })

  -- Language

  -- -- Lisp, Clojure, and Scheme
  use({ "eraserhd/parinfer-rust", run = "cargo build --release" })

  -- -- LaTeX
  use({
    "lervag/vimtex",
    config = function()
      require("plugins.vimtex").setup()
    end,
  })

  -- -- Markdown
  use({
    { "iamcco/markdown-preview.nvim", run = "cd app && yarn install" },
    -- { "tpope/vim-markdown" },
    -- TODO: check the problem.
    -- {
    --   "lukas-reineke/headlines.nvim",
    --   config = function()
    --     require("headlines").setup()
    --   end,
    -- },
    {
      "SidOfc/mkdx",
      ft = { "markdown", "md", "rmarkdown", "rmd" },
      config = function()
        require("plugins.mkdx").setup()
      end,
    },
    { "ellisonleao/glow.nvim", cmd = "Glow" },
  })

  -- -- Rust
  use({
    { "simrat39/rust-tools.nvim" },
    {
      "Saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      config = function()
        require("crates").setup()
      end,
    },
  })

  -- -- TypeScript
  use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PackerBootstrap then
    require("packer").sync()
  end
end)

pcall(require, "impatient")
