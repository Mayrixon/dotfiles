local M = {}

local mappings = {



  -- Search
  ['s'] = {
    name = 'Search',
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
  r = {
    name = 'Run',
    s = {'<Cmd>lua require\'sniprun\'.run(\'v\')<CR>', 'Run snippets'}
  },
  g = {name = 'Source code', y = {name = 'Git URL'}}
}

return M
