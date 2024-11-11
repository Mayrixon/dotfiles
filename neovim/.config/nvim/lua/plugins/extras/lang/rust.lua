return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  {
    "rustaceanvim",
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<LocalLeader>a", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr })
          vim.keymap.set("n", "<LocalLeader>d", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Rust Debuggables", buffer = bufnr })
        end,
      },
    },
  },
  ------------------------------ End modification ------------------------------
}
