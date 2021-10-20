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
      use {'wbthomason/packer.nvim', opt = true}

      -- Development
      use {'tpope/vim-surround'}
      use {'tpope/vim-commentary'}
      use {'tpope/vim-unimpaired'}
      use {'tpope/vim-sleuth'}
      use {'easymotion/vim-easymotion'}
      use {'voldikss/vim-floaterm'}
      use {'windwp/nvim-spectre'}
      use {
        'folke/which-key.nvim',
        config = function() require('config.which-key').setup() end
      }
      use {
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
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
      use {
        'mbbill/undotree',
        cmd = 'UndotreeToggle',
        config = function() require('config.undotree').setup() end
      }

      -- Git
      use {'tpope/vim-fugitive'}
      use {'tpope/vim-rhubarb'}
      use {'tpope/vim-dispatch'}
      use {'junegunn/gv.vim'}
      use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require('config.gitsigns').setup() end
      }
      use {
        'TimUntersberger/neogit',
        requires = {'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim'},
        config = function()
          require('neogit').setup({integrations = {diffview = true}})
        end
      }
      use {'sindrets/diffview.nvim'}

      -- Colorscheme
      use {'npxbr/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}
      use {
        'kyazdani42/nvim-web-devicons',
        config = function()
          require('nvim-web-devicons').setup {default = true}
        end
      }

      -- Testing
      --    use {
      --      "rcarriga/vim-ultest",
      --      config = "require('config.test').setup()",
      --      run = ":UpdateRemotePlugins",
      --      requires = { "vim-test/vim-test" },
      --    }

      -- Telescope
      use {
        'nvim-telescope/telescope.nvim',
        requires = {
          'nvim-lua/plenary.nvim', {
            'nvim-telescope/telescope-arecibo.nvim',
            rocks = {'openssl', 'lua-http-parser'}
          }, {
            'nvim-telescope/telescope-frecency.nvim',
            requires = {
              'tami5/sqlite.lua', {'kyazdani42/nvim-web-devicons', opt = true}
            }
          }, {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
          'nvim-telescope/telescope-project.nvim',
          'TC72/telescope-tele-tabby.nvim'
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

      -- LSP config
      use {'neovim/nvim-lspconfig'}

      -- Better LSP experience
      use {'onsails/lspkind-nvim'}
      use {'nvim-lua/lsp-status.nvim'}
      use {
        'mhartington/formatter.nvim',
        config = function() require('config.formatter-config').setup() end
      }
      use {'ray-x/lsp_signature.nvim'}
      -- TODO: add keymappings to which-key hintss
      use {
        'rmagatti/goto-preview',
        config = function()
          require('goto-preview').setup({default_mappings = true, height = 30})
        end
      }
      -- TODO: add keymappings to keymapping config file.
      -- TODO: set highlight group.
      -- TODO: set blacklist filetypes.
      use {
        'RRethy/vim-illuminate',
        config = function()
          vim.api.nvim_set_keymap('n', '<a-n>',
                                  '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>',
                                  {noremap = true})
          vim.api.nvim_set_keymap('n', '<a-p>',
                                  '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
                                  {noremap = true})
        end
      }
      use {
        'andymass/vim-matchup',
        config = function() require('config.matchup').setup() end
      }

      -- Completion
      use {
        'hrsh7th/nvim-cmp',
        requires = {
          'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp',
          'saadparwaiz1/cmp_luasnip', 'hrsh7th/cmp-nvim-lua',
          'octaltree/cmp-look', 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc',
          'f3fora/cmp-spell', 'hrsh7th/cmp-emoji', 'ray-x/cmp-treesitter'
        },
        config = function() require('config.cmp').setup() end
      }
      use {
        'tzachar/cmp-tabnine',
        run = './install.sh',
        requires = 'hrsh7th/nvim-cmp',
        config = function() require('config.tabnine').setup() end
      }

      -- Snippets
      use {
        'L3MON4D3/LuaSnip',
        config = function() require('config.luasnip').setup() end
      }
      use {'rafamadriz/friendly-snippets'}

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
      -- use { 'nvim-telescope/telescope-media-files.nvim' }
      -- use { 'nvim-telescope/telescope-packer.nvim ' }
      -- use {
      --     'lewis6991/spellsitter.nvim',
      --     config = function() require('spellsitter').setup() end
      -- }

      -- Better syntax
      use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('todo-comments').setup {} end
      }

      -- Editor
      use {'junegunn/vim-easy-align'}
      use {
        'folke/trouble.nvim',
        config = function() require('trouble').setup {} end
      }
      use {
        'Pocco81/TrueZen.nvim',
        requires = {
          'folke/twilight.nvim',
          opt = true,
          config = function() require('twilight').setup {context = 20} end
        },
        config = function() require('config.truezen').setup() end
      }

      -- Dashboard
      -- TODO: setup
      use {
        'goolord/alpha-nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function()
          require('alpha').setup(require('alpha.themes.dashboard').opts)
        end
      }

      -- Status line
      use {
        'shadmansaleh/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function() require('config.lualine').setup() end
      }
      use {
        'SmiteshP/nvim-gps',
        requires = 'nvim-treesitter/nvim-treesitter',
        config = function() require('nvim-gps').setup({}) end
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
      use {'ellisonleao/glow.nvim'}
      -- use {'mzlogin/vim-markdown-toc'}

      -- Pandoc
      -- use {'vim-pandoc/vim-pandoc'}
      -- use {'vim-pandoc/vim-pandoc-syntax'}
      -- use {'vim-pandoc/vim-pandoc-after'}

      -- Rust
      -- use {'rust-lang/rust.vim'}
      use {'simrat39/rust-tools.nvim'}

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

      ---- TypeScript
      -- use { "jose-elias-alvarez/nvim-lsp-ts-utils" }

      ---- Note taking
      -- use {'jbyuki/nabla.nvim'}
      -- use {'vimwiki/vimwiki', branch = 'dev'}

      ---- Trying
      -- use { "lewis6991/impatient.nvim" }
      -- Embed in browser
      -- use {'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

      ---- Profiling
      -- use {
      --  'dstein64/vim-startuptime',
      --  cmd = 'StartupTime',
      --  config = [[vim.g.startuptime_tries = 10]]
      -- }
      -- use{'tweekmonster/startuptime.vim'}

      ---- Editor interface
      use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
          require('indent_blankline').setup {
            show_current_context = true,
            use_treesitter = true
          }
        end
      }

      -- use {'ntpeters/vim-better-whitespace'}
      -- use {'ludovicchabant/vim-gutentags'}
      -- use {'norcalli/nvim-colorizer.lua'}

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

-- Colorscheme
-- use {'NLKNguyen/papercolor-theme'}
-- use {'folke/tokyonight.nvim'}
-- use {'sainnhe/everforest'}
-- use {'sainnhe/gruvbox-material'}

-- use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
-- use {'Yggdroot/indentLine' }

-- use {'itchyny/lightline.vim'}
-- use {'sainnhe/gruvbox-material'}

-- Lua config enhancement
-- use {'tjdevries/astronauta.nvim'}

-- LSP config
-- use {'kabouzeid/nvim-lspinstall'}
-- use {'tamago324/nlsp-settings.nvim'}
-- use {'jose-elias-alvarez/null-ls.nvim'}

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

-- use {'sbdchd/neoformat'}

-- use {'junegunn/goyo.vim', requires = {'junegunn/limelight.vim'}}
