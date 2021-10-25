local cursor_theme = require('config.telescope').cursor_theme

local M = {}

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
      d = {
        '<Cmd>TroubleToggle lsp_document_diagnostics<CR>',
        'Document diagnostics'
      },
      D = {
        '<Cmd>TroubleToggle lsp_workspace_diagnostics<CR>',
        'Workspace diagnostics'
      },
      f = {function() vim.lsp.buf.formatting() end, 'Format'},
      o = {'<Cmd>Telescope lsp_document_symbols<CR>', 'Document symbols'},
      r = {function() vim.lsp.buf.rename() end, 'Rename'},

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

    T = {
      d = {
        function() require('config.lsp.utils').toggle_diagnostics() end,
        'Diagnostics'
      }
    }
  },
  visual_mode = {
    l = {
      name = 'LSP',
      a = {
        function()
          require('telescope.builtin').lsp_range_code_actions(cursor_theme)
        end, 'Range action'
      }
    }
  }
}

M.capability_mappings = {
  {
    'document_range_formatting',
    {lF = {function() vim.lsp.buf.range_formatting() end, 'Range format'}},
    '<leader>', 'visual'
  }, {
    'code_lens', {
      l = {
        l = {
          name = 'Code lens',

          l = {'<Cmd>lua vim.lsp.codelens.refresh()<CR>', 'Codelens refresh'},
          r = {'<Cmd>lua vim.lsp.codelens.run()<CR>', 'Codelens run'}
        }
      }
    }, '<leader>', 'normal'
  }
}

return M
