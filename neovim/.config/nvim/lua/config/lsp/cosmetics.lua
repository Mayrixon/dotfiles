local function set_borders(border_type)
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border_type })
  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = border_type })

  require("lsp_signature").setup({
    bind = true,
    handler_opts = { border = border_type },
  })
end

local function set_diagnostic_column_signs()
  local signs = {
    Error = " ",
    Warning = " ",
    Hint = " ",
    Information = " ",
  }

  for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end
end

local on_publish_diagnostics_handles = {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
}

local function set_on_publish_diagnostics()
  vim.g.diagnostics_active = true
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    require("config.lsp.cosmetics").on_publish_diagnostics_handles
  )
end

local M = {
  on_publish_diagnostics_handles = on_publish_diagnostics_handles,
  set_on_publish_diagnostics = set_on_publish_diagnostics,
}

function M.setup(settings)
  M.border_type = settings.cosmetics.border_type

  set_borders(M.border_type)
  set_diagnostic_column_signs()
  set_on_publish_diagnostics()
end

function M.set_document_highlight(client)
  if client.resolved_capabilities.document_highlight then
    vim.cmd([[
      hi default link LspReferenceText CursorColumn
      hi default link LspReferenceRead LspReferenceText
      hi default link LspReferenceWrite LspReferenceText
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]])
  end
end

return M
