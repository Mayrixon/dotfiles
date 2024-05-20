return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        beancount = {
          init_options = {
            journal_file = "~/Sync/Personal/Beancount/main.beancount",
          },
        },
      },
    },
  },
}
