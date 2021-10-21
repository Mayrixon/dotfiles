-- TODO: add :Format to <localleader>-f in visual mode.
local M = {}

-- TODO: add yank to <localleader>y
M.normal_mappings = {
  f = {'<Cmd>Format<CR>', 'Format'},

  -- TODO: add paste in v mode
  P = {'"+P', 'Paste before here'},
  p = {'"+p', 'Paste after here'}
}

return M
-- TODO: refac export
