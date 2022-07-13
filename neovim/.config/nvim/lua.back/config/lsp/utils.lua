local M = {}

vim.g.diagnostics_active = true
local function disable_diagnostics()
  vim.g.diagnostics_active = false
  vim.diagnostic.hide()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
end
M.disable_diagnostics = disable_diagnostics

local function enable_diagnostics()
  vim.g.diagnostics_active = true
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    require("config.lsp.cosmetics").on_publish_diagnostics_handles
  )
end
M.enable_diagnostics = enable_diagnostics

function M.toggle_diagnostics()
  if vim.g.diagnostics_active then
    disable_diagnostics()
    print("Diagnostics Off")
  else
    enable_diagnostics()
    print("Diagnostics On")
  end
end

return M
