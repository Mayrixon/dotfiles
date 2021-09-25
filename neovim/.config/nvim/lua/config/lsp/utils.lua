-- TODO: refactor the LSP settings.
local M = {}

local lsp_status = require('lsp-status')

local function document_highlight(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      hi default link LspReferenceText CursorColumn
      hi default link LspReferenceRead LspReferenceText
      hi default link LspReferenceWrite LspReferenceText
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorHold <buffer> lua require('lspsaga.diagnostic').show_cursor_diagnostics()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]]
  end
end

-- TODO: consider move keymappings into overall mapping files
local function set_buffer_keymap(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = {noremap = true, silent = true}

  local n_keybindings = {
    ['[d'] = '<Cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<cr>',
    [']d'] = '<Cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<cr>',
    ['gd'] = '<Cmd>lua require("lspsaga.provider").preview_definition()<CR>',
    ['gi'] = '<Cmd>lua vim.lsp.buf.implementation()<CR>',
    ['gl'] = '<Cmd>lua require("lspsaga.provider").lsp_finder()<CR>',
    ['gr'] = '<Cmd>lua vim.lsp.buf.references()<CR>',
    ['gD'] = '<Cmd>lua vim.lsp.buf.declaration()<CR>',
    ['K'] = '<Cmd>lua require("lspsaga.hover").render_hover_doc()<CR>',
    ['<C-f>'] = '<Cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>',
    ['<C-b>'] = '<Cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>',
    ['<C-k>'] = '<Cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>'
  }

  local n_leader_keybindings = {
    ['<leader>ac'] = '<cmd>lua require("lspsaga.codeaction").code_action()<CR>',
    ['<leader>ld'] = '<cmd>lua require("lspsaga.diagnostic").show_line_diagnostics()<CR>',
    ['<leader>ll'] = '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',
    ['<leader>lr'] = '<cmd>lua require("lspsaga.rename").rename()<CR>',
    ['<leader>lt'] = '<cmd>lua vim.lsp.buf.type_definition()<CR>'
  }
  buf_set_keymap('v', '<leader>ac',
                 ':<C-U>lua require("lspsaga.codeaction").range_code_action()<CR>',
                 opts)

  local keybindings =
      vim.tbl_extend('keep', n_keybindings, n_leader_keybindings)
  for key, binding in pairs(keybindings) do
    buf_set_keymap('n', key, binding, opts)
  end

  -- Set some keybinds conditional on server capabilities
  -- TODO: use cmd Neoformat instead of Format
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>',
                   opts)
  else
    buf_set_keymap('n', '<leader>lf', '<cmd>Format<CR>', opts)
  end

  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('v', '<leader>lrf',
                   '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end
end

local function set_buffer_option(bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local function get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- lsp_status settings
  capabilities = vim.tbl_extend('keep', capabilities or {},
                                lsp_status.capabilities)

  -- for nvim-cmp
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  ---- Code actions
  -- capabilities.textDocument.codeAction = {
  --  dynamicRegistration = true,
  --  codeActionLiteralSupport = {
  --    codeActionKind = {
  --      valueSet = (function()
  --        local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
  --        table.sort(res)
  --        return res
  --      end)()
  --    }
  --  }
  -- }

  -- capabilities.textDocument.completion.completionItem.snippetSupport = true
  -- capabilities.textDocument.completion.completionItem.resolveSupport = {
  --  properties = {'documentation', 'detail', 'additionalTextEdits'}
  -- }
  -- capabilities.experimental = {}
  -- capabilities.experimental.hoverActions = true

  return capabilities
end

local function on_attach(client, bufnr)
  lsp_status.on_attach(client)
  require('lsp_signature').on_attach()

  set_buffer_keymap(client, bufnr)
  set_buffer_option(bufnr)

  document_highlight(client)
end

function M.setup_server(server, config)
  local lspconfig = require('lspconfig')

  local updated_config = vim.tbl_deep_extend('force', {
    on_attach = on_attach,
    -- on_exit = M.lsp_exit,
    -- on_init = M.lsp_init,
    capabilities = get_capabilities()
    -- flags = {debounce_text_changes = 150},
  }, config)

  lspconfig[server].setup(updated_config)

  local cfg = lspconfig[server]
  if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
    print(server .. ': cmd not found: ' .. vim.inspect(cfg.cmd))
  end
end

return M
