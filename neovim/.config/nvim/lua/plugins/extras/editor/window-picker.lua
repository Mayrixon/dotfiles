return {
  {
    "s1n7ax/nvim-window-picker",
    opts = {
      filter_rules = {
        -- filter using buffer options
        bo = {
          -- if the file type is one of following, the window will be ignored
          filetype = { "notify", "Lazy", "mason", "Trouble" },

          -- if the buffer type is one of following, the window will be ignored
          buftype = { "terminal", "quickfix" },
        },
      },
    },
  },
}
