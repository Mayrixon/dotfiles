return require('packer').startup({
  config = {
    compile_path = vim.fn.stdpath('data') .. '/packer_compiled.lua',
    display = {open_fn = require('packer.util').float}
  },
  function()
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    use {'tpope/vim-sleuth'}

    -- Color sheme
    use {'morhetz/gruvbox'}
    -- use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
    use {'sainnhe/gruvbox-material'}

    -- Fuzzy finder
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    -- LSP and completion
    use {
      'neovim/nvim-lspconfig',
      requires = {'glepnir/lspsaga.nvim', 'ray-x/lsp_signature.nvim'}
    }
    use {'onsails/lspkind-nvim'}
    use {'hrsh7th/nvim-compe'}
    use {'hrsh7th/vim-vsnip'}
    use {'hrsh7th/vim-vsnip-integ'}

    -- File expolorer
    use {'kyazdani42/nvim-web-devicons'}
    use {'kyazdani42/nvim-tree.lua'}

    -- Profiling
    use {
      'dstein64/vim-startuptime',
      cmd = 'StartupTime',
      config = [[vim.g.startuptime_tries = 10]]
    }

    use {'tpope/vim-surround'}

    use {'folke/which-key.nvim'}
    use {'junegunn/vim-easy-align'}
    use {'scrooloose/nerdcommenter'}
    use {'ntpeters/vim-better-whitespace'}
    use {'ludovicchabant/vim-gutentags'}
    use {'airblade/vim-gitgutter'}
    use {'liuchengxu/vista.vim'}
    use {'junegunn/limelight.vim'}
    use {'junegunn/goyo.vim'}
    use {'lervag/vimtex'}
    use {'tpope/vim-markdown'}
    use {'SidOfc/mkdx'}
    use {'npxbr/glow.nvim'}
    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}
    use {'mhartington/formatter.nvim'}
    use {'itchyny/lightline.vim'}

    -- Terminal
    use {'voldikss/vim-floaterm'}

    -- Undo tree
    use {'mbbill/undotree', cmd = 'UndotreeToggle'}

    use {
      'nvim-treesitter/nvim-treesitter',
      requires = {
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-textobjects'
      },
      run = ':TSUpdate'
    }
  end
})
