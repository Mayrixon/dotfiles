-- TODO: refactor the LSP settings.
local M = {}

-- TODO: config lsp_status. Only display the server status.
-- Delete warnings, errors, hints, and locations.
-- local lsp_status = require('lsp-status')

local function set_document_highlight(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      hi default link LspReferenceText CursorColumn
      hi default link LspReferenceRead LspReferenceText
      hi default link LspReferenceWrite LspReferenceText
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
"        autocmd CursorHold <buffer> lua require('lspsaga.diagnostic').show_cursor_diagnostics()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]]
  end
end

local function set_keymap_1(bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = {noremap = true, silent = true}

  local keybindings = require('keymappings').lsp_keymappings.normal_mode

  for key, binding in pairs(keybindings) do
    buf_set_keymap('n', key, binding, opts)
  end
end

local function set_keymap_3(bufnr)
  local mappings = {
    l = {
      name = 'LSP',
      a = {'<Cmd>Telescope lsp_code_actions<CR>', 'Code actions'},
      d = {
        function() vim.lsp.diagnostic.show_line_diagnostics() end,
        'Show line diagnostics'
      },
      f = {function() vim.lsp.buf.formatting() end, 'Format'},
      o = {'<Cmd>Telescope lsp_document_symbols<CR>', 'Document symbols'},
      r = {function() vim.lsp.buf.rename() end, 'Rename'},

      l = {
        function() vim.lsp.diagnostic.set_loclist() end, 'Buffer diagnostics'
      },
      T = {function() vim.lsp.buf.type_definition() end, 'Type definition'},

      -- TODO: compare with goto-preview
      u = {'<Cmd>Telescope lsp_references<CR>', 'References'},
      D = {'<Cmd>Telescope lsp_definitions<CR>', 'Definition'},

      e = {'<Cmd>lua vim.lsp.diagnostic.enable()<CR>', 'Enable diagnostics'},
      x = {'<Cmd>lua vim.lsp.diagnostic.disable()<CR>', 'Disable diagnostics'},
      t = {'<Cmd>TroubleToggle<CR>', 'Trouble'}
    },
    w = {
      name = 'Workspace',
      a = {
        function() vim.lsp.buf.add_workspace_folder() end,
        'Add Workspace folder'
      },
      l = {
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'List workspace folders'
      },
      r = {
        function() vim.lsp.buf.remove_workspace_folder() end,
        'Remove Workspace folder'
      }
    }
  }

  require('which-key').register(mappings, {
    mode = 'n',
    buffer = bufnr,
    prefix = '<leader>'
  })
end

local function set_keymap_2(client, bufnr)
  set_keymap_3(bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = {noremap = true, silent = true}

  buf_set_keymap('v', '<leader>la',
                 ':<C-U>lua vim.lsp.buf.range_code_action()<CR>', opts)

  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('v', '<leader>lF',
                   '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end
end

local function set_buffer_keymap(client, bufnr)
  set_keymap_1(bufnr)
  set_keymap_2(client, bufnr)
end

local function set_buffer_option(bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local function set_cosmetics(border_kind)
  vim.lsp.handlers['textDocument/hover'] =
      vim.lsp.with(vim.lsp.handlers.hover, {border = border_kind})
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
                                                       vim.lsp.handlers
                                                           .signature_help,
                                                       {border = border_kind})
end

function M.get_general_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- lsp_status settings
  -- capabilities = vim.tbl_extend('keep', capabilities or {},
  --                               lsp_status.capabilities)

  -- for nvim-cmp
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  return capabilities
end

function M.on_attach(client, bufnr)
  local border_kind = nil
  -- set_cosmetics(border_kind)

  -- require'lsp_signature'.setup({
  --   bind = true,
  --   handler_opts = {border = border_kind}
  -- })

  -- lsp_status.on_attach(client)

  set_buffer_keymap(client, bufnr)
  set_buffer_option(bufnr)

  set_document_highlight(client)
end

return M
