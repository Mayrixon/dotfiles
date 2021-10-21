local M = {}

function M.set_buffer_option(bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

M.set_keymap_1 = require('keymappings').api.set_keymap_1

M.set_keymap_2 = require('keymappings').api.set_keymap_2

function M.set_document_highlight(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      hi default link LspReferenceText CursorColumn
      hi default link LspReferenceRead LspReferenceText
      hi default link LspReferenceWrite LspReferenceText
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]]
  end
end

function M.set_hover_diagnostics()
  vim.cmd [[
    augroup lsp_cursor_diagnostics
      autocmd!
      autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})
    augroup END
  ]]
end

return M
-- TODO: refac export
