local M = {}

local mappings = {

  -- System
  ['z'] = {
    name = 'System',
    h = {'<Cmd>15sp +term<CR>', 'New horizontal terminal'},
    t = {'<Cmd>terminal<CR>', 'New terminal'},
    e = {'!!$SHELL<CR>', 'Execute line'},
    z = {
      '<Cmd>lua require(\'config.telescope\').search_dotfiles()<CR>',
      'Configuration'
    },
    p = {
      ':let &runtimepath.=\',\'.escape(expand(\'%:p:h\'), \'\\,\')<Cr>',
      'Set runtime path'
    },
    f = {'<Cmd>FloatermNew<Cr>', 'Floating terminal'}
  },

  -- File
  f = {
    name = 'File',
    p = {'<Cmd>Telescope file_browser<Cr>', 'Pop-up file browser'},
    x = {'<Cmd>DashboardFindHistory<Cr>', 'History'},
    m = {'<Cmd>DashboardJumpMark<Cr>', 'Mark'},
    n = {'<Cmd>DashboardNewFile<Cr>', 'New file'},
    a = {'<Cmd>xa<Cr>', 'Save all & quit'}
  },

  -- Git
  g = {
    name = 'Source code',
    d = {'<Cmd>Gvdiffsplit<Cr>', 'Git diff'},
    g = {name = 'Generate doc'}
  },

  -- Project
  p = {
    name = 'Project',
    s = {
      '<Cmd>lua require(\'config.telescope\').switch_projects()<CR>',
      'Search files'
    }
  },

  -- Search
  ['s'] = {
    name = 'Search',
    b = {'<Plug>SearchNormal', 'Browser search'},
    o = {'<Cmd>SymbolsOutline<CR>', 'Symbols Outline'}
  },

  -- Testing
  t = {
    name = 'Test',
    n = {'<Cmd>w<CR>:TestNearest<CR>', 'Test nearest'},
    f = {'<Cmd>w<CR>:TestFile<CR>', 'Test file'},
    s = {'<Cmd>w<CR>:TestSuite<CR>', 'Test suite'},
    l = {'<Cmd>w<CR>:TestLast<CR>', 'Test last'},
    v = {'<Cmd>w<CR>:TestVisit<CR>', 'Test visit'}
  },

  -- Run
  r = {
    name = 'Run',
    s = {'<Cmd>lua require\'sniprun\'.run()<CR>', 'Run snippets'}
  },

  -- Notes
  n = {
    name = 'Notes',
    n = {'<Cmd>FloatermNew nvim ~/workspace/dev/notes/<Cr>', 'New note'}
  }

}

local vmappings = {
  s = {name = 'Search', b = {'<Plug>SearchVisual', 'Browser search'}},
  r = {
    name = 'Run',
    s = {'<Cmd>lua require\'sniprun\'.run(\'v\')<CR>', 'Run snippets'}
  },
  g = {name = 'Source code', y = {name = 'Git URL'}}
}

local lsp_mappings_opts = {
  {
    'document_formatting',
    {['lf'] = {'<Cmd>lua vim.lsp.buf.formatting()<CR>', 'Format'}}
  },
  {
    'code_lens',
    {['ll'] = {'<Cmd>lua vim.lsp.codelens.refresh()<CR>', 'Codelens refresh'}}
  }, {
    'code_lens',
    {['ls'] = {'<Cmd>lua vim.lsp.codelens.run()<CR>', 'Codelens run'}}
  }
}

local dap_nvim_dap_mappings = {
  d = {
    name = 'DAP',
    b = {
      '<Cmd>lua require(\'dap\').toggle_breakpoint()<CR>', 'Toggle breakpoint'
    },
    c = {'<Cmd>lua require(\'dap\').continue()<CR>', 'Continue'},
    s = {'<Cmd>lua require(\'dap\').step_over()<CR>', 'Step over'},
    i = {'<Cmd>lua require(\'dap\').step_into()<CR>', 'Step into'},
    o = {'<Cmd>lua require(\'dap\').step_out()<CR>', 'Step out'},
    u = {'<Cmd>lua require(\'dapui\').toggle()<CR>', 'Toggle UI'},
    p = {'<Cmd>lua require(\'dap\').repl.open()<CR>', 'REPL'},
    e = {
      '<Cmd>lua require"telescope".extensions.dap.commands{}<CR>', 'Commands'
    },
    f = {
      '<Cmd>lua require"telescope".extensions.dap.configurations{}<CR>',
      'Configurations'
    },
    r = {
      '<Cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>',
      'List breakpoints'
    },
    v = {
      '<Cmd>lua require"telescope".extensions.dap.variables{}<CR>', 'Variables'
    },
    m = {'<Cmd>lua require"telescope".extensions.dap.frames{}<CR>', 'Frames'}
  }
}

local dap_vimspector_mappings = {
  d = {
    name = 'DAP',
    b = {'<Cmd>call vimspector#ToggleBreakpoint()<CR>', 'Toggle breakpoint'},
    c = {'<Cmd>call vimspector#Continue()<CR>', 'Continue'},
    s = {'<Cmd>call vimspector#StepOver()<CR>', 'Step over'},
    i = {'<Cmd>call vimspector#StepInto()<CR>', 'Step into'},
    o = {'<Cmd>call vimspector#StepOut()<CR>', 'Step out'},
    u = {'<Cmd>call vimspector#Launch()<CR>', 'Launch'},
    f = {
      '<Cmd>lua require(\'telescope\').extensions.vimspector.configurations()<CR>',
      'Configurations'
    }
  }

  --- REFACTORING WIP
  --
  -- Vimspector
  -- ["<F5>"] = {name = "Vimspector - Launch"},
  -- ["<F8>"] = {name = "Vimspector - Run to Cursor"},
  -- ["<F9>"] = {name = "Vimspector - Cond. Breakpoint"},

  --     utils.map_key('n', '<leader>dsc',
  --                   '<cmd>lua require"dap.ui.variables".scopes()<CR>')
  --     utils.map_key('n', '<leader>dhh',
  --                   '<cmd>lua require"dap.ui.variables".hover()<CR>')
  --     utils.map_key('v', '<leader>dhv',
  --                   '<cmd>lua require"dap.ui.variables".visual_hover()<CR>')

  --     utils.map_key('n', '<leader>duh',
  --                   '<cmd>lua require"dap.ui.widgets".hover()<CR>')
  --     utils.map_key('n', '<leader>duf',
  --                   "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")

  --     utils.map_key('n', '<leader>dsbr',
  --                   '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
  --     utils.map_key('n', '<leader>dsbm',
  --                   '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
  --     utils.map_key('n', '<leader>drl',
  --                   '<cmd>lua require"dap".repl.run_last()<CR>')
}

function M.register_dap_vimspector()
  local wk = require 'which-key'
  wk.register({
    ['dx'] = {
      ':lua require(\'config.which-key\').register_dap_nvim_dap()<CR>',
      'Switch to nvim-dap'
    }
  }, opts)
  wk.register(dap_vimspector_mappings, opts)
  vim.g.my_debugger = 'v'
  vim.g.vimspector_enable_mappings = 'HUMAN'
end

function M.register_dap_nvim_dap()
  local wk = require 'which-key'
  wk.register({
    ['dx'] = {
      ':lua require(\'config.which-key\').register_dap_vimspector()<CR>',
      'Switch to vimspector'
    }
  }, opts)
  wk.register(dap_nvim_dap_mappings, opts)
  vim.g.my_debugger = 'd'
  vim.g.vimspector_enable_mappings = ''
end

function M.register_dap()
  if vim.g.my_debugger == 'v' then
    M.register_dap_vimspector()
  else
    M.register_dap_nvim_dap()
  end
end

return M
