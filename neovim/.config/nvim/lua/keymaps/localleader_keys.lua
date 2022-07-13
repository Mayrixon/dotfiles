local M = {}

M.normal = {
  f = { "<Cmd>Format<CR>", "Format" },
  p = { '"+p', "Paste after here" },
  P = { '"+P', "Paste before here" },
  Y = { '"+y', "Yank the line" },
  y = { '"+y', "Yank", noremap = false },
}

M.visual = {
  f = { "<Cmd>Format<CR>", "Format" },
  p = { '"+p', "Paste" },
  Y = { '"+y', "Yank the line" },
  y = { '"+y', "Yank" },
}

return M
