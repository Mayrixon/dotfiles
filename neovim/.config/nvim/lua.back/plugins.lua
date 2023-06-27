return {

  -- -- Completion
  {
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-calc", dependencies = "nvim-cmp" },
    { "hrsh7th/cmp-emoji", dependencies = "nvim-cmp" },
    { "f3fora/cmp-spell", dependencies = "nvim-cmp" },
    { "ray-x/cmp-treesitter", dependencies = { "nvim-cmp", "nvim-treesitter/nvim-treesitter" } },
    { "octaltree/cmp-look", dependencies = "nvim-cmp" },
    { "hrsh7th/cmp-cmdline", dependencies = "nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp-document-symbol", dependencies = "nvim-cmp" },
  },

  -- -- Formatter
  {
    "mhartington/formatter.nvim",
    config = function()
      -- INFO: there is a formatter taplo could be used for toml.
      local filetypes = require("formatter.filetypes")

      require("formatter").setup({
        logging = true,
        filetype = {
          cmake = { filetypes.cmake.cmakeformat },
          tex = {
            -- latexindent
            function()
              return {
                exe = "latexindent",
                args = { "-sl", "-g /dev/stderr", "2>/dev/null" },
                stdin = true,
              }
            end,
          },
        },
      })
    end,
  },

  -- -- Linter
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        text = { "vale" },
        lua = { "luacheck" },
        markdown = { "vale" },
        python = { "pylint" },
        rst = { "vale" },
        sh = { "shellcheck" },
        viml = { "vint" },
      }
    end,
  },

  -- Git
  {
    { "junegunn/gv.vim" },
  },

  -- Search
  { "dbeniamine/cheat.sh-vim" },

  -- Treesitter
  {
    { "windwp/nvim-ts-autotag" },
  },

  -- Language

  -- -- Lisp, Clojure, and Scheme
  { "eraserhd/parinfer-rust", build = "cargo build --release" },

  -- -- TypeScript
  { "jose-elias-alvarez/nvim-lsp-ts-utils" },
}
