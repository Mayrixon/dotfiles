local M = {}

local mappings = {

  -- File
  f = {name = 'File', a = {'<Cmd>xa<Cr>', 'Save all & quit'}},

  -- Git
  g = {name = 'Source code', g = {name = 'Generate doc'}},

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

return M
