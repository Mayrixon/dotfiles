return require('packer').startup(function()

  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}


  -- Color sheme
  use { 'morhetz/gruvbox' }
  --use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  use { 'sainnhe/gruvbox-material' }

  -- Fuzzy finder
  use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- LSP and completion
  -- TODO: cleanup the setting files
  -- TODO: find and turn off the function that auto highlight the
  --       word under the cursor after around 5 seconds
  use { 'neovim/nvim-lspconfig' }
  use {
      'hrsh7th/nvim-compe',
      config = [[require('plugin-config.compe')]],
      event = 'InsertEnter *'
  }
  use { 'glepnir/lspsaga.nvim' }
  use { 'onsails/lspkind-nvim' }
  use { 'nvim-lua/lsp-status.nvim' }
  -- TODO: config
  -- use { 'ray-x/lsp_signature.nvim' }
  --Plug 'jubnzv/virtual-types.nvim'

  -- Snippets
  use { 'hrsh7th/vim-vsnip' }

  -- Lua development
  use { 'tjdevries/nlua.nvim' }

  -- Fugitive for Git
  use { 'tpope/vim-fugitive' }


  -- TODO: organize all following plugins
  -- TODO: update according to previous settings
  use { "folke/which-key.nvim" }


-- use { 'kyazdani42/nvim-web-devicons' }
  use { 'kyazdani42/nvim-tree.lua' }

  -- Zen mode
  -- https://github.com/hrsh7th/nvim-compe/issues/159
  -- goyo, limelight
  -- typewriter scrolling: set scrolloff=999

  -- Highlight
  -- https://github.com/p00f/nvim-ts-rainbow
  -- TODO: clean up 'config.treesitter'
  -- use {
  --     'nvim-treesitter/nvim-treesitter',
  --     run = ':TSUpdate',
  --     config = [[require('plugin-config.treesitter')]]
  -- }

  -- Registers
  use { 'junegunn/vim-peekaboo' }

  -- Undo tree
  use {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
  }

  -- Markdown
  -- https://github.cm/npxbr/glow.nvim
  -- https://github.com/iamcco/markdown-preview.nvim
  -- https://github.com/SidOfc/mkdx
  -- TODO: double check markdown plugins after treesitter PR#872
  -- TODO: add config file in folder plugin
  use { 'plasticboy/vim-markdown' }

  -- From previous settings
  -- TODO: following plugins only requiring keybindings
  use { 'tpope/vim-sleuth' }
  use { 'npxbr/glow.nvim' }
  use { 'airblade/vim-gitgutter' }

  -- TODO: following plugins requiring configuration and keybindings
  use { 'scrooloose/nerdcommenter' }
  use { 'tpope/vim-surround' }

  -- TODO: following plugins requiring confirm with Lua virsion.

use 'jiangmiao/auto-pairs'
use 'easymotion/vim-easymotion'
use 'nathanaelkane/vim-indent-guides'

use 'itchyny/lightline.vim'
use 'ntpeters/vim-better-whitespace'
use 'luochen1990/rainbow'
use 'junegunn/rainbow_parentheses.vim'
use 'junegunn/limelight.vim'
use 'junegunn/goyo.vim'

use 'junegunn/vim-easy-align'
use 'mg979/vim-visual-multi'

use 'ludovicchabant/vim-gutentags'
use 'liuchengxu/vista.vim'

use 'junegunn/gv.vim'
use 'sodapopcan/vim-twiggy'

use 'honza/vim-snippets'
use 'Konfekt/FastFold'
use 'tmhedberg/SimpylFold'


use 'lervag/vimtex'
use 'cespare/vim-toml'
use 'ron-rs/ron.vim'
use 'tikhomirov/vim-glsl'
use 'wlangstroth/vim-racket'
use 'SidOfc/mkdx'
use 'iamcco/markdown-preview.nvim'


use 'skywind3000/vim-terminal-help'

use 'liuchengxu/vim-which-key'
use 'chrisbra/Colorizer'
use 'AndrewRadev/linediff.vim'
use 'junegunn/fzf.vim'

use 'lambdalisue/suda.vim'


  use {'tpope/vim-dispatch', cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Marks
--  use {'kshenoy/vim-signature', config = [[require('config.signature')]], disable = true}

  -- Buffer management
  use {'mhinz/vim-sayonara', cmd = 'Sayonara'}

  -- Movement
--  use {'chaoren/vim-wordmotion', {'justinmk/vim-sneak', config = [[require('config.sneak')]]}}

  -- Quickfix
  use {'Olical/vim-enmasse', cmd = 'EnMasse'}

  -- Indentation tracking
--  use {
--    'lukas-reineke/indent-blankline.nvim',
--    branch = 'lua',
--    setup = [[require('config.indentline')]]
--  }

  -- Commenting
  -- use 'tomtom/tcomment_vim'

  -- Wrapping/delimiters
--  use {'machakann/vim-sandwich', {'andymass/vim-matchup', setup = [[require('config.matchup')]]}}

  -- Search
  use 'romainl/vim-cool'

  -- Prettification
--  use {'junegunn/vim-easy-align', config = [[require('config.easy_align')]]}
--  use {'mhartington/formatter.nvim', config = [[require('config.format')]]}

  -- Text objects
  use 'wellle/targets.vim'

  -- Search
--  use {
--    'nvim-telescope/telescope.nvim',
--    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
--    setup = [[require('config.telescope_setup')]],
--    config = [[require('config.telescope')]],
--    cmd = 'Telescope'
--  }

--  use {'nvim-telescope/telescope-frecency.nvim', requires = 'tami5/sql.nvim'}

  -- Project Management/Sessions
--  use {
--    'dhruvasagar/vim-prosession',
--    after = 'vim-obsession',
--    requires = {{'tpope/vim-obsession', cmd = 'Prosession'}},
--    config = [[require('config.prosession')]]
--  }


  -- Git
--  use {
--    {'tpope/vim-fugitive', cmd = {'Gstatus', 'Gblame', 'Gpush', 'Gpull'}}, {
--      'lewis6991/gitsigns.nvim',
--      requires = {'nvim-lua/plenary.nvim'},
--      config = [[require('config.gitsigns')]]
--    }, {'TimUntersberger/neogit', opt = true}
--  }

  -- Pretty symbols
  use 'kyazdani42/nvim-web-devicons'

  -- Terminal
  use 'voldikss/vim-floaterm'

  -- REPLs
--  use {
--    'hkupty/iron.nvim',
--    setup = [[vim.g.iron_map_defaults = 0]],
--    config = [[require('config.iron')]],
--    cmd = {'IronRepl', 'IronSend', 'IronReplHere'}
--  }

  -- Completion and linting
  -- use {
  --   'onsails/lspkind-nvim', 'neovim/nvim-lspconfig', 'nvim-lua/lsp-status.nvim',
  --   'glepnir/lspsaga.nvim'
  -- }

  -- Highlights
--  use {
--    'nvim-treesitter/nvim-treesitter',
--    requires = {
--      'nvim-treesitter/nvim-treesitter-refactor', 'nvim-treesitter/nvim-treesitter-textobjects'
--    },
--    config = [[require('config.treesitter')]]
--  }

  -- Just for tracking progess until this is ready for use
  use {'mfussenegger/nvim-lint', opt = true}

--  use {'hrsh7th/nvim-compe', config = [[require('config.compe')]], event = 'InsertEnter *'}
--  use {'hrsh7th/vim-vsnip', config = [[require('config.vsnip')]], event = 'InsertEnter *'}

  -- Debugger
  use {'mfussenegger/nvim-dap', opt = true}
  use {
    'puremourning/vimspector',
    setup = [[vim.g.vimspector_enable_mappings = 'HUMAN']],
    disable = true
  }

  -- Path navigation
  use 'justinmk/vim-dirvish'

  -- LaTeX
--  use {'lervag/vimtex', config = [[require('config.vimtex')]]}

  -- Meson
  use 'igankevich/mesonic'


  -- Profiling
  use {'dstein64/vim-startuptime', cmd = 'StartupTime', config = [[vim.g.startuptime_tries = 10]]}

  -- Highlight colors
  use {
    'norcalli/nvim-colorizer.lua',
    ft = {'css', 'javascript', 'vim', 'html'},
    config = [[require('colorizer').setup {'css', 'javascript', 'vim', 'html'}]]
  }
end)
