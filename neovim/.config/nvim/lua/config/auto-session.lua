local M = {}

function M.setup()
  require('auto-session').setup({
    auto_session_root_dir = vim.fn.stdpath('data') .. '/sessions/',
    auto_save_enabled = false,
    auto_restore_enabled = false
  })

  vim.opt.sessionoptions = vim.opt.sessionoptions +
                               {'options', 'resize', 'winpos', 'terminal'}
end

return M
