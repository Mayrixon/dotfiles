return require('packer').startup(function()
    
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}


  -- Color sheme
  use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
  use { 'sainnhe/gruvbox-material' }

  -- Fuzzy finder
  use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- LSP and completion
  -- TODO: cleanup the setting files
  -- TODO: find and turn off the function that auto highlight the
  -- word under the cursor after around 5 seconds
  use { 'neovim/nvim-lspconfig' }
  use {
      'hrsh7th/nvim-compe',
      config = [[require('plugin-config.compe')]],
      event = 'InsertEnter *'
  }
  use { 'glepnir/lspsaga.nvim' }
  use { 'onsails/lspkind-nvim' }
  use { 'nvim-lua/lsp-status.nvim' }
  --  ray-x /lsp_signature.nvim 
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

  -- Markdown
  -- https://github.com/npxbr/glow.nvim
  -- https://github.com/iamcco/markdown-preview.nvim
  -- https://github.com/SidOfc/mkdx
  

  -- Zen mode
  -- https://github.com/hrsh7th/nvim-compe/issues/159
  -- goyo, limelight
  -- typewriter scrolling: set scrolloff=999
  --
  -- Highlight
  -- https://github.com/p00f/nvim-ts-rainbow
  -- TODO: clean up 'config.treesitter'
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = [[require('plugin-config.treesitter')]]
  }

  -- Registers
  use { 'junegunn/vim-peekaboo' }

  -- Undo tree
  use {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    config = [[vim.g.undotree_SetFocusWhenToggle = 1]]
  }

  -- Markdown
  -- TODO: double check markdown plugins after treesitter PR#872
  -- TODO: add config file in folder plugin
  use { 'plasticboy/vim-markdown' }
end)
