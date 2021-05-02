call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sleuth'

Plug 'jiangmiao/auto-pairs'
Plug 'nathanaelkane/vim-indent-guides'

" Appearance
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'luochen1990/rainbow'
" Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'

" Editing
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'mg979/vim-visual-multi'
Plug 'easymotion/vim-easymotion'

" Ctags
Plug 'ludovicchabant/vim-gutentags'
Plug 'liuchengxu/vista.vim', {'on': ['Vista', 'Vista!', 'Vista!!']}

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'sodapopcan/vim-twiggy'

" Auto-everything
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'Konfekt/FastFold'
Plug 'tmhedberg/SimpylFold'

" Languages

Plug 'lervag/vimtex'
Plug 'cespare/vim-toml'
Plug 'ron-rs/ron.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'wlangstroth/vim-racket'
Plug 'SidOfc/mkdx'
Plug 'iamcco/markdown-preview.nvim', {'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}


" Build and debug
Plug 'skywind3000/vim-terminal-help'

" Utilities
Plug 'liuchengxu/vim-which-key'
Plug 'chrisbra/Colorizer'
Plug 'mbbill/undotree'
Plug 'AndrewRadev/linediff.vim'
Plug 'junegunn/fzf.vim'

Plug 'junegunn/vim-peekaboo'
Plug 'lambdalisue/suda.vim'

call plug#end()
