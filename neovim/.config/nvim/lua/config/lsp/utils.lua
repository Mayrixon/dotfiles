local M = {}

function M.set_buffer_option(bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

function M.set_keymap_1(bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = {noremap = true, silent = true}

  local keybindings = require('keymappings').lsp_keymappings.normal_mode

  for key, binding in pairs(keybindings) do
    buf_set_keymap('n', key, binding, opts)
  end
end

function M.set_keymap_2(client, bufnr)
  local wk = require('which-key')

  local n_opts = {mode = 'n', buffer = bufnr, prefix = '<leader>'}
  local v_opts = {mode = 'v', buffer = bufnr, prefix = '<leader>'}

  local n_mappings = {
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
  local v_mappings = {
    l = {
      name = 'LSP',
      a = {function() vim.lsp.buf.range_code_action() end, 'Range action'}
    }
  }

  wk.register(n_mappings, n_opts)
  wk.register(v_mappings, v_opts)

  if client.resolved_capabilities.document_range_formatting then
    wk.register({
      lF = {function() vim.lsp.buf.range_formatting() end, 'Range format'}
    }, v_opts)
  end
end

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

return M
