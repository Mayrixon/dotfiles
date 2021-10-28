-- TODO: clean up all commented lines
local function bootstrap(packer_bootstrap)
  local packer = require('packer')
  if packer_bootstrap then
    function _G.add_patch_file()
      local patch_file_path = vim.fn.stdpath('config') .. '/plugin/patch.lua'
      local added_command = 'local patch_file_path = ' .. '\'' ..
                                patch_file_path .. '\'' .. '\n' ..
                                'for package, _ in pairs(_G.packer_plugins) do require(\'packer\').loader(package) end\n' ..
                                'require(\'packer\').compile()\n' ..
                                'os.remove(patch_file_path)'
      vim.cmd('edit $MYVIMRC')
      packer.compile()
      local file = io.open(patch_file_path, 'a')
      file:write(added_command)
      file:close()
    end
    vim.cmd [[
      autocmd User PackerComplete call v:lua.add_patch_file()
      autocmd User PackerCompileDone sleep 100m
    ]]
    packer.sync()
  end
end

local function init()
  local fn = vim.fn

  local packer_bootstrap = false
  local install_path = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    local output = fn.system({
      'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim', install_path
    })
    if output ~= '' then packer_bootstrap = true end
  end
  vim.cmd [[packadd packer.nvim]]

  return packer_bootstrap
end

local function startup()
  local packer = require('packer')

  packer.startup({
    config = {profile = {enable = true}},
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
        cmd = {
          'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFindFile',
          'NvimTreeFindFileToggle', 'NvimTreeFocus'
        },
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
      use {
        'andymass/vim-matchup',
        config = function() require('config.matchup').setup() end
      }

      -- Git
      use {'tpope/vim-fugitive'}
      use {'tpope/vim-rhubarb'}
      use {'tpope/vim-dispatch'}
      use {'junegunn/gv.vim'}
      use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        event = 'BufReadPre',
        config = function() require('config.gitsigns').setup() end
      }
      use {
        'TimUntersberger/neogit',
        requires = {'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim'},
        cmd = 'Neogit',
        config = function()
          require('neogit').setup({integrations = {diffview = true}})
        end
      }
      use {
        'sindrets/diffview.nvim',
        cmd = {
          'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles',
          'DiffviewFocusFiles'
        }
      }

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
        cmd = 'Telescope',
        module = 'telescope',
        config = function() require('config.telescope').setup() end
      }
      use {'nvim-telescope/telescope-packer.nvim'}
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
        event = 'VimEnter',
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
      use {
        'rmagatti/goto-preview',
        event = 'BufWinEnter',
        config = function()
          require('goto-preview').setup({default_mappings = true, height = 30})
        end
      }
      use {
        'RRethy/vim-illuminate',
        config = function() require('config.illuminate').setup() end
      }
      use {
        'mfussenegger/nvim-lint',
        config = function() require('config.lint').setup() end
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
        event = 'BufWinEnter',
        config = function() require('config.cmp').setup() end
      }
      use {
        'tzachar/cmp-tabnine',
        run = './install.sh',
        requires = 'hrsh7th/nvim-cmp',
        event = 'BufWinEnter',
        config = function() require('config.tabnine').setup() end
      }

      -- Snippets
      use {
        'L3MON4D3/LuaSnip',
        event = 'VimEnter',
        config = function() require('config.luasnip').setup() end
      }
      use {'rafamadriz/friendly-snippets'}

      -- Treesitter
      use {
        'nvim-treesitter/nvim-treesitter',
        require = {
          {'nvim-treesitter/nvim-treesitter-textobjects'},
          {'p00f/nvim-ts-rainbow'},
          {'JoosepAlviste/nvim-ts-context-commentstring'},
          {'romgrk/nvim-treesitter-context'}, {'windwp/nvim-ts-autotag'}, {
            'lewis6991/spellsitter.nvim',
            config = function() require('spellsitter').setup() end
          }
        },
        run = ':TSUpdate',
        event = 'BufRead',
        config = function() require('config.treesitter').setup() end
      }

      -- Better syntax
      use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('todo-comments').setup {} end
      }

      -- Editor
      use {'junegunn/vim-easy-align'}
      use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
          require('indent_blankline').setup {
            show_current_context = true,
            use_treesitter = true
          }
        end
      }
      use {
        'ntpeters/vim-better-whitespace',
        config = function() require('config.whitespace').setup() end
      }
      use {
        'norcalli/nvim-colorizer.lua',
        event = 'BufWinEnter',
        config = function() require('colorizer').setup() end
      }
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
      use {'google/vim-searchindex'}

      -- Dashboard
      use {
        'goolord/alpha-nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function()
          require('alpha').setup(require('alpha.themes.startify').opts)
        end
      }

      -- Cheat sheet
      use {
        'sudormrfbin/cheatsheet.nvim',
        cmd = 'Cheatsheet',
        requires = {'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim'}
      }

      -- Status line
      use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function() require('config.lualine').setup() end
      }
      use {
        'SmiteshP/nvim-gps',
        requires = 'nvim-treesitter/nvim-treesitter',
        config = function() require('nvim-gps').setup({}) end
      }

      ---- Debugging
      -- use { "puremourning/vimspector", event = "BufWinEnter" }
      -- use { "nvim-telescope/telescope-vimspector.nvim", event = "BufWinEnter" }

      ---- DAP
      use {'mfussenegger/nvim-dap'}
      use {'nvim-telescope/telescope-dap.nvim'}
      -- use { "mfussenegger/nvim-dap-python" }
      -- use { "theHamsta/nvim-dap-virtual-text" }
      -- use { "rcarriga/nvim-dap-ui" }
      -- use { "Pocco81/DAPInstall.nvim" }
      -- use { "jbyuki/one-small-step-for-vimkind" }

      -- LaTeX
      use {
        'lervag/vimtex',
        config = function() require('config.vimtex').setup() end
      }

      -- Markdown
      use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}
      -- INFO: remove after treesitter supports markdown
      use {'tpope/vim-markdown'}
      use {
        'SidOfc/mkdx',
        config = function() require('config.mkdx').setup() end
      }
      use {'ellisonleao/glow.nvim', cmd = 'Glow'}

      -- Pandoc
      -- use {'vim-pandoc/vim-pandoc'}
      -- use {'vim-pandoc/vim-pandoc-syntax'}
      -- use {'vim-pandoc/vim-pandoc-after'}

      -- Rust
      -- use {'rust-lang/rust.vim'}
      use {'simrat39/rust-tools.nvim'}

      ---- TypeScript
      -- use { "jose-elias-alvarez/nvim-lsp-ts-utils" }

      ---- Note taking
      -- use {'jbyuki/nabla.nvim'}
      -- use {'vimwiki/vimwiki', branch = 'dev'}

      ---- Trying
      use {'lewis6991/impatient.nvim'}
      -- Embed in browser
      -- use {'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

      ---- Profiling
      use {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
        config = [[vim.g.startuptime_tries = 10]]
      }

    end
  })
end

local M = {}

function M.setup()
  local packer_bootstrap = init()

  startup()

  bootstrap(packer_bootstrap)
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
-- use {'ludovicchabant/vim-gutentags'}
