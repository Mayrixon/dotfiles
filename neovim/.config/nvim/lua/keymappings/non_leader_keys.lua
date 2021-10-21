local M = {}

M.mappings = {
  insert_mode = {
    ['<M-H>'] = '<ESC><C-w>h',
    ['<M-L>'] = '<ESC><C-w>l',
    ['<M-J>'] = '<ESC><C-w>j',
    ['<M-K>'] = '<ESC><C-w>k',
    -- Break undo sequence
    [','] = ',<c-g>u',
    ['.'] = '.<c-g>u',
    ['!'] = '!<c-g>u',
    ['?'] = '?<c-g>u',
    -- Unmap <F1>
    ['<F1>'] = '<ESC>'
  },
  normal_mode = {
    ['ga'] = {'<Plug>(EasyAlign)', {noremap = false, silent = false}},
    ['<F1>'] = '<Cmd>FloatermToggle<CR>',
    ['<F2>'] = '<Cmd>Vista!!<CR>',
    ['<C-l>'] = '<Cmd>noh<CR>',

    ['<M-H>'] = '<C-w>h',
    ['<M-L>'] = '<C-w>l',
    ['<M-J>'] = '<C-w>j',
    ['<M-K>'] = '<C-w>k'
  },
  term_mode = {
    ['<F1>'] = '<C-\\><C-n><Cmd>FloatermToggle<CR>',
    ['<M-q>'] = '<C-\\><C-n>',
    ['<M-H>'] = '<C-\\><C-n><c-w>h',
    ['<M-L>'] = '<C-\\><C-n><c-w>l',
    ['<M-J>'] = '<C-\\><C-n><c-w>j',
    ['<M-K>'] = '<C-\\><C-n><c-w>k',
    ['<M-N>'] = '<C-\\><C-n><c-w>p',
    ['<M-->'] = '<C-\\><C-n>"0pa'
  },
  visual_mode = {},
  visual_block_mode = {
    ['ga'] = {'<Plug>(EasyAlign)', {noremap = false, silent = false}}
  },
  command_mode = {
    -- ['w!!'] = 'execute \'silent! write !sudo tee % >/dev/null\' <bar> edit!'
  }
}

-- TODO: add g, [, and ]
M.hints = {
  -- TODO: LSP-enabled only. buffer in opts would be useful
  gd = 'Definition',
  gl = 'LSP finder',

  ga = 'EasyAlign',
  gc = 'Comments',
  -- gp = '',
  -- gP = '',

  ['[d'] = 'Previous diagnostic',
  [']d'] = 'Next diagnostic'

}

M.wk_operators = {ga = 'EasyAlign', gc = 'Comments'}

return M
