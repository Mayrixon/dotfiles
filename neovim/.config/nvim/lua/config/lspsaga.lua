local M = {}

function M.setup()
  local saga = require('lspsaga')
  saga.init_lsp_saga({code_action_keys = {quit = {'<ESC>', 'q'}}})
end

return M
