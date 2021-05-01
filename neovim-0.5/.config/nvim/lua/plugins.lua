return require('packer').startup(function()
    
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}


  -- Color sheme
  use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

  -- Fuzzy finder
  use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- LSP and completion
  -- TODO: cleanup the setting files
  use { 'neovim/nvim-lspconfig' }
  use { 'hrsh7th/nvim-compe' }
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

  -- Markdown
  -- https://github.com/npxbr/glow.nvim
  -- https://github.com/iamcco/markdown-preview.nvim
  -- https://github.com/SidOfc/mkdx
  

  -- Zen mode
  -- https://github.com/hrsh7th/nvim-compe/issues/159
  -- goyo, limelight
  -- typewriter scrolling: set scrolloff=999
  --
  -- Tree sitter
  -- https://github.com/p00f/nvim-ts-rainbow
  --

end)
