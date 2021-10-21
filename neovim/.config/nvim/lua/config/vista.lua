local M = {}

function M.setup()
  vim.g.vista_sidebar_position = 'vertical botright'
  vim.g.vista_default_executive = 'nvim_lsp'
  vim.g.vista_echo_cursor_strategy = 'floating_win'
  vim.g.vista_update_on_text_changed = 1
end

return M
-- TODO: refac export
