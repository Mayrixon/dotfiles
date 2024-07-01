return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  -- TODO: check this plugin.
  { "mini.pairs", enabled = false },
  ------------------------------ End modification ------------------------------

  -- auto pairs
  -- TODO: if mini.pairs could be used, remove this plugin.
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = { check_ts = true, fast_wrap = {} },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      if LazyVim.has("nvim-cmp") then
        local cmp = require("cmp")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },

  -- surround
  -- TODO: find the surround plugin in LazyVim.
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },

  -- comments
  -- TODO: find the comment plugin in LazyVim.
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
