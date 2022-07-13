local M = {}

function M.setup()
  require("auto-session").setup({
    auto_save_enabled = true,
    auto_restore_enabled = false,
  })

  vim.opt.sessionoptions = vim.opt.sessionoptions + { "winpos", "terminal" }
end

return M
