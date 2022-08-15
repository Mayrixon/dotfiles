local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    autotag = { enable = true },
    context = { enable = true },
    context_commentstring = { enable = true },
    ensure_installed = {
      "bash",
      "beancount",
      "bibtex",
      "c",
      "css",
      "cmake",
      "cpp",
      "glsl",
      "html",
      "http",
      "javascript",
      "json",
      "json5",
      "latex",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "norg",
      "org",
      "python",
      "r",
      "rust",
      "toml",
      "typescript",
      "vim",
      "wgsl",
      "yaml",
    },
    highlight = { enable = true, disable = { "latex" } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    indent = { enable = true },
    matchup = { enable = true },
    rainbow = { enable = true, extended_mode = true },
    textobjects = {
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
        goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = { ["<leader>es"] = "@parameter.inner" },
        swap_previous = { ["<leader>eS"] = "@parameter.inner" },
      },
    },
  })

  vim.opt_global.foldmethod = "expr"
  vim.opt_global.foldexpr = "nvim_treesitter#foldexpr()"
end

return M
