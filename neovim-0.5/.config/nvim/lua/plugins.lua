return require('packer').startup(function()

    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}

    use {'tpope/vim-sleuth'}

    -- Color sheme
    use {'morhetz/gruvbox'}
    -- use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
    use {'sainnhe/gruvbox-material'}

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
end)
