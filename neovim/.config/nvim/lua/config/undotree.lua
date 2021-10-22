local M = {}

function M.setup()
  vim.opt_global.undofile = true

  vim.g.undotree_SetFocusWhenToggle = 1

  -- TODO: confirm this part with goyo
  -- https://vi.stackexchange.com/a/14006
  -- " using relative positioning instead
  -- let g:undotree_CustomUndotreeCmd = 'vertical 32 new'
  -- let g:undotree_CustomDiffpanelCmd= 'belowright 12 new'

  -- " changing from the default 80 to accomodate for UndoTree panel
  -- let g:goyo_width = 104
end

return M
