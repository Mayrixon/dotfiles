-- Automatically install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- General
  { "tpope/vim-sleuth" },
  { "voldikss/vim-floaterm", event = "VimEnter" },
  {
    "liuchengxu/vista.vim",
    config = function()
      require("plugins.vista").setup()
    end,
  },

  -- -- Async building & commands
  { "tpope/vim-dispatch", cmd = { "Dispatch", "Make", "Focus", "Start" } },

  -- -- Cheatsheet
  {
    "sudormrfbin/cheatsheet.nvim",
    cmd = "Cheatsheet",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },

  -- -- Colorscheme
  { "ellisonleao/gruvbox.nvim", dependencies = { "rktjmp/lush.nvim" } },

  -- -- Dashboard
  {
    "goolord/alpha-nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").opts)
    end,
  },

  -- -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
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
  },

  -- -- Key hints
  {
    { "folke/which-key.nvim" },
    { "junegunn/vim-peekaboo" },
  },

  -- -- Status line
  {
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
    },
    {
      "SmiteshP/nvim-navic",
      dependencies = "neovim/nvim-lspconfig",
    },
    { "nanozuki/tabby.nvim" },
    {
      "j-hui/fidget.nvim",
      event = "BufReadPre",
      config = function()
        require("fidget").setup()
      end,
    },
  },

  -- -- Render
  {
    {
      "norcalli/nvim-colorizer.lua",
      event = "BufWinEnter",
      config = function()
        require("colorizer").setup({
          "*",
          -- "!packer",
        })
      end,
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      dependencies = "nvim-treesitter/nvim-treesitter",
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
      dependencies = "nvim-lua/plenary.nvim",
      event = "VimEnter",
      config = function()
        require("todo-comments").setup({})
      end,
    },
  },

  -- -- UI improvements
  { "stevearc/dressing.nvim", event = "BufWinEnter" },

  -- -- Zen mode
  {
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
  },

  -- Edit
  {
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
      build = "make",
      config = function()
        require("plugins.nvim-autopairs").setup()
      end,
    },
  },
  { "kevinhwang91/nvim-bqf", event = "BufWinEnter" },

  -- -- Completion
  {
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "onsails/lspkind-nvim",
        "lukas-reineke/cmp-under-comparator",
      },
      event = "InsertEnter *",
      config = function()
        require("plugins.cmp").setup()
      end,
    },
    { "hrsh7th/cmp-nvim-lsp", dependencies = "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-buffer", dependencies = "nvim-cmp" },
    { "hrsh7th/cmp-nvim-lua", dependencies = "nvim-cmp" },
    { "hrsh7th/cmp-path", dependencies = "nvim-cmp" },
    { "hrsh7th/cmp-calc", dependencies = "nvim-cmp" },
    { "hrsh7th/cmp-emoji", dependencies = "nvim-cmp" },
    { "f3fora/cmp-spell", dependencies = "nvim-cmp" },
    { "ray-x/cmp-treesitter", dependencies = "nvim-cmp", dependencies = "nvim-treesitter/nvim-treesitter" },
    { "saadparwaiz1/cmp_luasnip", dependencies = "nvim-cmp", dependencies = "L3MON4D3/LuaSnip" },
    { "octaltree/cmp-look", dependencies = "nvim-cmp" },
    { "hrsh7th/cmp-cmdline", dependencies = "nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp-document-symbol", dependencies = "nvim-cmp" },
  },

  -- -- Document generation
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({ snippet_engine = "luasnip" })
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter", "L3MON4D3/LuaSnip" },
  },

  -- -- Formatter
  {
    "mhartington/formatter.nvim",
    config = function()
      require("plugins.formatter").setup()
    end,
  },

  -- -- Linter
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("plugins.lint").setup()
    end,
  },
  -- -- Snippets
  {
    "L3MON4D3/LuaSnip",
    event = "VimEnter",
    config = function()
      require("plugins.luasnip").setup()
    end,
  },
  { "rafamadriz/friendly-snippets" },

  -- Development
  -- -- REPLs
  {
    "michaelb/sniprun",
    cmd = { "SnipRun" },
    build = "bash install.sh",
    config = function()
      require("plugins.sniprun").setup()
    end,
  },

  -- Git
  {
    { "tpope/vim-fugitive", event = "BufRead", cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" } },
    { "tpope/vim-rhubarb" },
    { "junegunn/gv.vim" },
    {
      "lewis6991/gitsigns.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      event = "BufReadPre",
      config = function()
        require("plugins.gitsigns").setup()
      end,
    },
    {
      "sindrets/diffview.nvim",
      dependencies = "nvim-lua/plenary.nvim",
      cmd = {
        "DiffviewOpen",
        "DiffviewClose",
        "DiffviewToggleFiles",
        "DiffviewFocusFiles",
      },
    },
    {
      "TimUntersberger/neogit",
      dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
      cmd = "Neogit",
      config = function()
        require("neogit").setup({ integrations = { diffview = true } })
      end,
    },
  },

  -- LSP
  {
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
  },

  -- Search
  {
    {
      "kevinhwang91/nvim-hlslens",
      config = function()
        require("plugins.hlslens").setup()
      end,
    },
    { "nvim-pack/nvim-spectre" },
    { "voldikss/vim-browser-search" },
    {
      "folke/trouble.nvim",
      event = "VimEnter",
      config = function()
        require("trouble").setup({})
      end,
    },
  },
  { "dbeniamine/cheat.sh-vim" },

  -- -- Telescope
  {
    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      cmd = "Telescope",
      config = function()
        require("plugins.telescope").setup()
      end,
    },
    {
      "nvim-telescope/telescope-frecency.nvim",
      dependencies = {
        "tami5/sqlite.lua",
        { "kyazdani42/nvim-web-devicons", lazy = true },
      },
    },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
      "nvim-telescope/telescope-project.nvim",
      dependencies = {
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
    -- { "nvim-telescope/telescope-packer.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    {
      "rmagatti/session-lens",
      dependencies = {
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
  },

  -- Treesitter
  {
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
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
  },

  -- Language

  -- -- Lisp, Clojure, and Scheme
  { "eraserhd/parinfer-rust", build = "cargo build --release" },

  -- -- LaTeX
  {
    "lervag/vimtex",
    config = function()
      require("plugins.vimtex").setup()
    end,
  },

  -- -- Markdown
  {
    { "iamcco/markdown-preview.nvim", build = "cd app && yarn install" },
    {
      "lukas-reineke/headlines.nvim",
      dependencies = "nvim-treesitter",
      config = function()
        require("headlines").setup()
      end,
    },
    {
      "SidOfc/mkdx",
      ft = { "markdown", "md", "rmarkdown", "rmd" },
      config = function()
        require("plugins.mkdx").setup()
      end,
    },
    {
      "ellisonleao/glow.nvim",
      cmd = "Glow",
      config = function()
        require("glow").setup()
      end,
    },
  },

  -- -- Rust
  {
    { "simrat39/rust-tools.nvim" },
    {
      "Saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      config = function()
        require("crates").setup()
      end,
    },
  },

  -- -- TypeScript
  { "jose-elias-alvarez/nvim-lsp-ts-utils" },
})
