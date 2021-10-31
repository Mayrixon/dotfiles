local M = {}

M.normal_mappings = {
  f = {'<Cmd>Format<CR>', 'Format'},

  p = {'"+p', 'Paste after here'},
  P = {'"+P', 'Paste before here'},
  y = {'"+y', 'Yank', noremap = false},
  Y = {'"+y', 'Yank the line'}
}

M.visual_mappings = {
  f = {'<Cmd>Format<CR>', 'Format'},
  p = {'"+p', 'Paste'},
  y = {'"+y', 'Yank'},
  Y = {'"+y', 'Yank the line'}
}

return M
