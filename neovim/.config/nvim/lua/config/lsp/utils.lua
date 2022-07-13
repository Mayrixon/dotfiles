local M = {}

function M.set_buffer_option(bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

M.set_lsp_keymap = require("keymappings").api.set_lsp_keymap

function M.set_hover_diagnostics()
  vim.cmd([[
    augroup lsp_cursor_diagnostics
      autocmd!
      autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(0, {scope="line", {focusable=false, focus=false}})
    augroup END
  ]])
end

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
