-- TODO: complete the setup
local M = {}

function M.setup()
  local telescope = require('telescope')

  telescope.setup({extensions = {frecency = {show_scores = true}}})

  telescope.load_extension('fzf')
  telescope.load_extension('frecency')
  telescope.load_extension('session-lens')
end

return M
