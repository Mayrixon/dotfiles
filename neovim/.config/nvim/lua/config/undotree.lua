local M = {}

function M.setup()
  vim.opt_global.undofile = true

  vim.g.undotree_SetFocusWhenToggle = 1
end

return M
