local M = {}

local cursor_theme = require('telescope.themes').get_cursor({
  layout_config = {width = 80, height = 14}
})

M.non_leader = {
  normal_mode = {
    ['[d'] = '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
    [']d'] = '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
    ['gd'] = '<Cmd>lua vim.lsp.buf.definition()<CR>',
    ['gD'] = '<Cmd>lua vim.lsp.buf.declaration()<CR>',
    ['gi'] = '<Cmd>lua vim.lsp.buf.implementation()<CR>',
    ['gr'] = '<Cmd>lua vim.lsp.buf.references()<CR>',
    ['K'] = '<Cmd>lua vim.lsp.buf.hover()<CR>',
    ['<C-k>'] = '<Cmd>lua vim.lsp.buf.signature_help()<CR>'
  }
}

M.leader = {
  normal_mode = {
    l = {
      name = 'LSP',
      a = {
        function()
          require('telescope.builtin').lsp_code_actions(cursor_theme)
        end, 'Code actions'
      },
      f = {function() vim.lsp.buf.formatting() end, 'Format'},
      o = {'<Cmd>Telescope lsp_document_symbols<CR>', 'Document symbols'},
      r = {function() vim.lsp.buf.rename() end, 'Rename'},

      -- TODO: consider to remove or use Trouble to list.
      l = {
        function() vim.lsp.diagnostic.set_loclist() end, 'Buffer diagnostics'
      },
      T = {function() vim.lsp.buf.type_definition() end, 'Type definition'},

      -- TODO: consider moving to <leader>-T.
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
  },
  visual_mode = {
    l = {
      name = 'LSP',
      -- TODO: change to telescope.
      a = {function() vim.lsp.buf.range_code_action() end, 'Range action'}
    }
  }
}

return M
