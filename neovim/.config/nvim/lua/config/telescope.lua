local M = {}

function M.setup()
  local telescope = require('telescope')
  telescope.load_extension('fzf')
  telescope.load_extension('frecency')
  telescope.load_extension('session-lens')

  telescope.setup({extensions = {frecency = {show_scores = true}}})
end

return M
