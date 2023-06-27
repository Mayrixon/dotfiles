return {
  {
    "junegunn/vim-easy-align",
    event = "BufReadPost",
    keys = {
      { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, noremap = false, desc = "EasyAlign" },
    },
  },
}
