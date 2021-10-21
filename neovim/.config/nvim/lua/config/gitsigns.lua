local M = {}

function M.setup()
  require('gitsigns').setup({
    keymaps = {
      noremap = true,

      -- Hunk navigators
      ['n ]h'] = {
        expr = true,
        '&diff ? \']c\' : \'<cmd>lua require"gitsigns.actions".next_hunk()<CR>\''
      },
      ['n [h'] = {
        expr = true,
        '&diff ? \'[c\' : \'<cmd>lua require"gitsigns.actions".prev_hunk()<CR>\''
      },

      -- Text objects
      ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
      ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
    },
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'right_align',
      delay = 500
    }
  })
end

return M
-- TODO: refac export
