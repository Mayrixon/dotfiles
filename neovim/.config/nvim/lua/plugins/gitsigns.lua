local M = {}

function M.setup()
  require("gitsigns").setup({
    keymaps = {
      noremap = true,

      -- Hunk navigators
      ["n ]h"] = {
        expr = true,
        "&diff ? ']c' : '<Cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'",
      },
      ["n [h"] = {
        expr = true,
        "&diff ? '[c' : '<Cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'",
      },

      -- Text objects
      ["o ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
      ["x ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    },
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 1000,
    },
  })
end

return M
