return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<F1>", "<Cmd>ToggleTerm<CR>", desc = "ToggleTerm" },
      { "<F1>", "<C-\\><C-N><Cmd>ToggleTerm<CR>", mode = "t", desc = "ToggleTerm" },
      {
        "<Leader>gl",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local lazygit = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
            float_opts = {
              border = "curved",
            },
            -- function to run on opening the terminal
            on_open = function(term)
              vim.cmd("startinsert!")
              vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<Cmd>close<CR>", { noremap = true, silent = true })
            end,
            -- function to run on closing the terminal
            on_close = function(term)
              vim.cmd("startinsert!")
            end,
          })

          lazygit:toggle()
        end,
        desc = "Lazygit",
      },
    },
    config = true,
  },
}
