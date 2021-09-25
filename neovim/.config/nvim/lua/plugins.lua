-- TODO: clean up all commented lines
local M = {}

function M.setup()
  local packer = require 'packer'

  packer.startup({
    -- config = {
    --  display = {open_fn = require('packer.util').float},
    --  profile = {enable = true}
    -- },
    function(use)
      -- Packer can manage itself as an optional plugin
      use {'wbthomason/packer.nvim', opt = true}

      -- Development
      use {'tpope/vim-fugitive'}
      use {'tpope/vim-rhubarb'}
      use {'tpope/vim-dispatch'}
      use {'tpope/vim-surround'}
      use {'tpope/vim-commentary'}
      use {'tpope/vim-unimpaired'}
      use {'tpope/vim-sleuth'}
      use {'easymotion/vim-easymotion'}
      use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require('gitsigns').setup() end
      }
      use {
        'TimUntersberger/neogit',
        requires = {'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim'},
        config = function()
          require('neogit').setup({integrations = {diffview = true}})
        end
      }
      use {'sindrets/diffview.nvim'}
      use {'voldikss/vim-floaterm'}
      use {
        'folke/which-key.nvim',
        config = function() require('config.which-key').setup() end
      }
      use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require('config.nvim-tree').setup() end

      }
      use {
        'windwp/nvim-autopairs',
        config = function() require('config.nvim-autopairs').setup() end
      }
      use {
        'liuchengxu/vista.vim',
        config = function() require('config.vista').setup() end
      }
      -- TODO: setup keymapping
      use {
        'mbbill/undotree',
        cmd = 'UndotreeToggle',
        config = function() require('config.undotree').setup() end
      }

      -- Color scheme
      use {'npxbr/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}
      use {
        'kyazdani42/nvim-web-devicons',
        config = function()
          require('nvim-web-devicons').setup {default = true}
        end
      }
      use {'NLKNguyen/papercolor-theme'}
      use {'folke/tokyonight.nvim'}
      use {'sainnhe/everforest'}
      use {'folke/lsp-colors.nvim'}

      -- Testing
      --    use {
      --      "rcarriga/vim-ultest",
      --      config = "require('config.test').setup()",
      --      run = ":UpdateRemotePlugins",
      --      requires = { "vim-test/vim-test" },
      --    }

      -- Telescope
      -- TODO: config
      use {
        'nvim-telescope/telescope.nvim',
        requires = {
          'nvim-lua/plenary.nvim',
          {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}, {
            'nvim-telescope/telescope-frecency.nvim',
            requires = {'tami5/sqlite.lua', 'kyazdani42/nvim-web-devicons'}
          }
          --        "nvim-telescope/telescope-project.nvim",
          --        "nvim-telescope/telescope-symbols.nvim",
          -- 'nvim-telescope/telescope-github.nvim',
          -- 'nvim-telescope/telescope-hop.nvim'
        },
        config = function() require('config.telescope').setup() end
      }
      use {
        'rmagatti/session-lens',
        requires = {
          {
            'rmagatti/auto-session',
            config = function()
              require('config.auto-session').setup()
            end
          }, 'nvim-telescope/telescope.nvim'
        },
        config = function() require('session-lens').setup {} end
      }
      --    use {
      --      "ahmedkhalf/project.nvim",
      --      config = function()
      --        require("project_nvim").setup {}
      --      end,
      --    }
      -- use {'airblade/vim-rooter'}

      -- LSP config
      use {'neovim/nvim-lspconfig'}

      -- Better LSP experience
      use {
        'glepnir/lspsaga.nvim',
        config = function() require('config.lspsaga').setup() end
      }
      use {
        'onsails/lspkind-nvim',
        config = function() require('config.lspkind').setup() end
      }
      use {'nvim-lua/lsp-status.nvim'}
      -- TODO: change to neoformat because of easy to setup.
      use {
        'mhartington/formatter.nvim',
        config = function() require('config.formatter-config').setup() end
      }
      -- use { "sbdchd/neoformat" }
      use {'ray-x/lsp_signature.nvim'}
      -- use { "szw/vim-maximizer" }
      ---- use {'dbeniamine/cheat.sh-vim'}
      ---- use {'dyng/ctrlsf.vim'}
      ---- use {'pechorin/any-jump.vim'}
      -- use { "kevinhwang91/nvim-bqf" }
      use {
        'andymass/vim-matchup',
        -- TODO: move to folder lua/config
        config = function() vim.g.matchup_matchparen_offscreen = {} end
      }
      -- use {
      --  "nacro90/numb.nvim",
      --  config = function()
      --    require("numb").setup()
      --  end,
      -- }
      -- use { "antoinemadec/FixCursorHold.nvim" }
      -- use {
      --  "jose-elias-alvarez/null-ls.nvim",
      --  requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      -- }

      -- Completion
      -- TODO: finish plugin settings
      use {
        'hrsh7th/nvim-cmp',
        requires = {
          'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp',
          'quangnguyen30192/cmp-nvim-ultisnips', 'hrsh7th/cmp-nvim-lua',
          'octaltree/cmp-look', 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc',
          'f3fora/cmp-spell', 'hrsh7th/cmp-emoji', 'ray-x/cmp-treesitter'
        },
        config = function() require('config.cmp').setup() end
      }
      use {
        'tzachar/cmp-tabnine',
        run = './install.sh',
        requires = 'hrsh7th/nvim-cmp'
      }

      -- Snippets
      use {
        'SirVer/ultisnips',
        requires = {'honza/vim-snippets'},
        config = function() vim.g.UltiSnipsRemoveSelectModeMappings = 0 end
      }

      -- Treesitter
      use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('config.treesitter').setup() end
      }
      use {'nvim-treesitter/nvim-treesitter-refactor'}
      use {'nvim-treesitter/nvim-treesitter-textobjects'}
      use {'p00f/nvim-ts-rainbow'}
      use {'JoosepAlviste/nvim-ts-context-commentstring'}
      use {'romgrk/nvim-treesitter-context'}
      use {'windwp/nvim-ts-autotag'}

      -- Better syntax
      use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('todo-comments').setup {} end
      }

      -- Editor
      use {'junegunn/vim-easy-align'}
      -- TODO: add configures
      use {'junegunn/goyo.vim', requires = {'junegunn/limelight.vim'}}
      -- TODO: setup with telescope
      use {
        'folke/trouble.nvim',
        config = function() require('trouble').setup {} end
      }

      -- LaTeX
      -- TODO: reconfig ftplugins/tex
      use {
        'lervag/vimtex',
        config = function() require('config.vimtex').setup() end
      }

      -- Markdown
      -- TODO: reconfig change ftplugins/markdown
      use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}
      use {'tpope/vim-markdown'}
      use {'SidOfc/mkdx'}
      use {'npxbr/glow.nvim'}

      -- Rust
      -- use {'rust-lang/rust.vim'}
      use {'simrat39/rust-tools.nvim'}

      ---- Lua development
      -- use { "folke/lua-dev.nvim" }
      -- use {
      --  "simrat39/symbols-outline.nvim",
      --  config = function()
      --    require("config.symbols-outline").setup()
      --  end,
      -- }
      -- use { "~/workspace/dev/alpha2phi/alpha.nvim" }

      ---- Dashboard
      -- use {
      --  "glepnir/dashboard-nvim",
      --  config = function()
      --    require("config.dashboard").setup()
      --  end,
      -- }

      ---- use {
      ----   "goolord/alpha-nvim",
      ----   requires = { "kyazdani42/nvim-web-devicons" },
      ----   config = function()
      ----     require("alpha").setup(require("alpha.themes.dashboard").opts)
      ----   end,
      ---- }

      ---- Status line
      ---- use {
      ----   "famiu/feline.nvim",
      ----   config = function()
      ----     require("config.feline").setup()
      ----   end,
      ---- }
      ---- use {
      ----   "glepnir/galaxyline.nvim",
      ----   branch = "main",
      ----   config = function()
      ----     require("config.galaxyline").setup()
      ----   end,
      ---- }
      -- use {
      --  "hoob3rt/lualine.nvim",
      --  config = function()
      --    require("config.lualine").setup()
      --  end,
      -- }

      -- use {
      --  "akinsho/nvim-bufferline.lua",
      --  requires = "kyazdani42/nvim-web-devicons",
      --  config = function()
      --    require("config.bufferline").setup()
      --  end,
      -- }

      ---- Debugging
      -- use { "puremourning/vimspector", event = "BufWinEnter" }
      -- use { "nvim-telescope/telescope-vimspector.nvim", event = "BufWinEnter" }

      ---- DAP
      -- use { "mfussenegger/nvim-dap" }
      -- use { "nvim-telescope/telescope-dap.nvim" }
      -- use { "mfussenegger/nvim-dap-python" }
      -- use { "theHamsta/nvim-dap-virtual-text" }
      -- use { "rcarriga/nvim-dap-ui" }
      -- use { "Pocco81/DAPInstall.nvim" }
      -- use { "jbyuki/one-small-step-for-vimkind" }

      ---- Development workflow
      -- use { "voldikss/vim-browser-search" }
      -- use {
      --  "kkoomen/vim-doge",
      --  run = ":call doge#install()",
      --  config = function()
      --    require("config.doge").setup()
      --  end,
      -- }
      -- use {
      --  "michaelb/sniprun",
      --  run = "bash install.sh",
      --  config = function()
      --    require("config.sniprun").setup()
      --  end,
      -- }

      ---- TypeScript
      -- use { "jose-elias-alvarez/nvim-lsp-ts-utils" }

      ---- Note taking
      use {
        -- TODO: compare with orgmode
        'nvim-neorg/neorg',
        -- TODO: complete configurations according to the main page.
        -- config = function() require('config.neorg').setup() end,
        requires = 'nvim-lua/plenary.nvim'
      }

      ---- Trying
      -- use { "lewis6991/impatient.nvim" }
      ---- use {
      ----     "rcarriga/nvim-notify",
      ----     config = function() vim.notify = require("notify") end
      ---- }
      -- use {'SmiteshP/nvim-gps'}
      use {'windwp/nvim-spectre'}

      ---- Profiling
      -- use {
      --  'dstein64/vim-startuptime',
      --  cmd = 'StartupTime',
      --  config = [[vim.g.startuptime_tries = 10]]
      -- }

      ---- Editor interface
      use {'lukas-reineke/indent-blankline.nvim'}
      -- use {'itchyny/lightline.vim'}

      -- use {'ntpeters/vim-better-whitespace'}
      -- use {'ludovicchabant/vim-gutentags'}

    end
  })
end

return M

--------------------------------- Plugin Lists ---------------------------------
-- use {'wellle/targets.vim'}

-- use {'chrisbra/NrrwRgn'}
-- use {'liuchengxu/vim-which-key'}

-- use {'jiangmiao/auto-pairs'}

-- use {'unblevable/quick-scope'}
-- use {'phaazon/hop.nvim', as = 'hop'}

-- use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
-- use {'lukas-reineke/indent-blankline.nvim' }
-- use {'Yggdroot/indentLine' }

-- use {'sainnhe/gruvbox-material'}

-- Lua config enhancement
-- use {'tjdevries/astronauta.nvim'}

-- LSP config
-- use {'kabouzeid/nvim-lspinstall'}
-- use {'tamago324/nlsp-settings.nvim'}

-- Treesitter
-- use {'mfussenegger/nvim-ts-hint-textobject'}
-- use {'RRethy/nvim-treesitter-textsubjects'}

-- use {
--   'folke/zen-mode.nvim',
--   config = function() require('zen-mode').setup {} end
-- }
-- use {
--   'folke/twilight.nvim',
--   config = function() require('twilight').setup {} end
-- }

------------------------------- alpha2phi's list -------------------------------
-- Go
-- use {'ray-x/go.nvim', config = function() require('go').setup() end}

-- use { "jamestthompson3/nvim-remote-containers" }

-- use {
--     'kristijanhusak/orgmode.nvim',
--     config = function()
--         require('orgmode').setup {
--             org_agenda_files = {'~/workspace/dev/notes/**/*'},
--             org_default_notes_file = '~workspace/dev/notes/notes.org'
--         }
--     end
-- }

-- use {
--     "folke/persistence.nvim",
--     event = "BufReadPre",
--     module = "persistence",
--     config = function()
--         require("persistence").setup()
--         require("config.persistence")
--     end
-- }

-- use {'jupyter-vim/jupyter-vim'}
-- use {'svermeulen/vim-yoink'}
-- use {
--     'ray-x/navigator.lua',
--     requires = {
--         'ray-x/guihua.lua',
--         run = 'cd lua/fzy && make',
--         config = function() require'navigator'.setup() end
--     }
-- }

-- Writing and note taking

-- use {'Pocco81/HighStr.nvim'}
-- use {'gyim/vim-boxdraw'}
-- use {'preservim/vim-pencil'}
-- use {'preservim/vim-colors-pencil'}
-- use {'dhruvasagar/vim-dotoo'}
-- use {'dhruvasagar/vim-table-mode'}
-- use {'fmoralesc/vim-pad'}
-- use {'vimwiki/vimwiki', branch = 'dev'}
-- use {'blindFS/vim-taskwarrior'}
-- use {'tools-life/taskwiki'}
-- use {'powerman/vim-plugin-AnsiEsc'}

-- Presentation
-- use {'sotte/presenting.vim'}
-- use {'vim-pandoc/vim-pandoc'}
-- use {'vim-pandoc/vim-pandoc-syntax'}
-- use {'vim-pandoc/vim-pandoc-after'}

-- Testing
-- use {'FooSoft/vim-argwrap'}
-- use {'preservim/vimux'}

-- use {'vuciv/vim-bujo'}
-- use {'freitass/todo.txt-vim'}
-- use {'oberblastmeister/neuron.nvim', branch = 'unstable'}

-- use {'oberblastmeister/neuron.nvim' }
-- use {'junegunn/fzf', run = '-> fzf#install()' }
-- use {'junegunn/fzf.vim'}
-- use {'fiatjaf/neuron.vim' }

-- Project mgmt
-- use {'vim-ctrlspace/vim-ctrlspace' }

-- Embed in browser
-- use {'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

-- OSC 52 yank
-- use {'ojroques/vim-oscyank' }

-- Jupyter Vim
-- use {'jupyter-vim/jupyter-vim' }

-- Scratch pad
-- use {'metakirby5/codi.vim' }

-- Slime
-- use {'jpalardy/vim-slime' }

-- Neoterm
-- use {'kassio/neoterm' }

-- Better terminal
-- use {'nikvdp/neomux' }

-- use {
--     'dstein64/vim-startuptime',
--     cmd = 'StartupTime',
--     config = [[vim.g.startuptime_tries = 10]]
-- }

-- use {
--     'edluffy/specs.nvim',
--     config = function() require('specs').setup {} end
-- }

-- use {'ggandor/lightspeed.nvim'}

-- use {'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps'}
-- use {'tamago324/lir.nvim'}
-- use {'rhysd/committia.vim'}
-- use {
--     "akinsho/nvim-toggleterm.lua",
--     config = function() require("toggleterm").setup {} end
-- }
-- use {'tpope/vim-characterize'}
-- use {'norcalli/nvim-colorizer.lua'}
-- use {'kevinhwang91/rnvimr'}
-- use {'francoiscabrol/ranger.vim'}
-- use {'rbgrouleff/bclose.vim'}
-- use {'christoomey/vim-tmux-navigator'}
-- use {'mhinz/vim-signify'}
-- use {'radenling/vim-dispatch-neovim' }

-- use {'thaerkh/vim-workspace'}

-- use {'sainnhe/edge'}
-- use {'joshdick/onedark.vim'}

-- use {'camspiers/snap'}
-- use {
--     'nvim-telescope/telescope-arecibo.nvim',
--     rocks = {"openssl", "lua-http-parser"}
-- }
-- use { 'nvim-telescope/telescope-media-files.nvim' }
-- use { 'nvim-telescope/telescope-packer.nvim ' }

-- use {
--     'lewis6991/spellsitter.nvim',
--     config = function() require('spellsitter').setup() end
-- }

-- use {'npxbr/glow.nvim', run = ':GlowInstall'}
-- use {'mzlogin/vim-markdown-toc'}
-- use {'godlygeek/tabular'}

-- Development settings
-- use {'editorconfig/editorconfig-vim'}

-- Database
-- use {'tpope/vim-dadbod'}
-- use {'kristijanhusak/vim-dadbod-ui'}
-- use {'kristijanhusak/vim-dadbod-completion'}
-- use {'tpope/vim-dotenv' }

-- use {'tpope/vim-projectionist'}

-- use {'jbyuki/instant.nvim'}
-- use {'chrisbra/unicode.vim'}

-- use {
--     'ThePrimeagen/refactoring.nvim',
--     config = function() require("config.refactoring") end
-- }
-- use {
--     'ray-x/navigator.lua',
--     requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'},
--     config = function() require("navigator").setup {} end
-- }

-- use {'TaDaa/vimade'}
-- use {'junegunn/vim-peekaboo'}
-- use {'gennaro-tedesco/nvim-peekup'}
-- use {'wellle/context.vim'}
-- use {'beauwilliams/focus.nvim' }
-- use {'RRethy/vim-illuminate' }
-- use {'kosayoda/nvim-lightbulb' }

-- Plugin development
-- use {'bryall/contextprint.nvim'}
-- use {'nanotee/nvim-lua-guide'}
-- use {'rafcamlet/nvim-luapad'}
-- use {'thinca/vim-themis'}
-- use {'tpope/vim-scriptease'}
-- use {'junegunn/vader.vim'}
-- use {'milisims/nvim-luaref'}
-- use {'tjdevries/nlua.nvim'}
-- use {'metakirby5/codi.vim'}
-- use {'bfredl/nvim-luadev'}

-- Snippets
-- use {'L3MON4D3/LuaSnip'}
-- use {
--     'norcalli/snippets.nvim',
--     config = function() require("config.snippets") end
-- }
-- use {'nvim-telescope/telescope-snippets.nvim'}
