local M = {}

M.mappings = {
  insert_mode = {
    ["<M-H>"] = "<ESC><C-w>h",
    ["<M-J>"] = "<ESC><C-w>j",
    ["<M-K>"] = "<ESC><C-w>k",
    ["<M-L>"] = "<ESC><C-w>l",
    -- Break undo sequence
    [","] = ",<c-g>u",
    ["."] = ".<c-g>u",
    ["!"] = "!<c-g>u",
    ["?"] = "?<c-g>u",
    -- Unmap <F1>
    ["<F1>"] = "<ESC>",
  },
  normal_mode = {
    ["ga"] = { "<Plug>(EasyAlign)", { noremap = false, silent = false } },
    ["<F1>"] = "<Cmd>FloatermToggle<CR>",
    ["<F2>"] = "<Cmd>Vista!!<CR>",
    ["<C-l>"] = ":nohlsearch | echo ''<CR>",

    ["<M-H>"] = "<C-w>h",
    ["<M-J>"] = "<C-w>j",
    ["<M-K>"] = "<C-w>k",
    ["<M-L>"] = "<C-w>l",
  },
  term_mode = {
    ["<F1>"] = "<C-\\><C-n><Cmd>FloatermToggle<CR>",
    ["<M-->"] = '<C-\\><C-n>"0pa',
    ["<M-H>"] = "<C-\\><C-n><c-w>h",
    ["<M-J>"] = "<C-\\><C-n><c-w>j",
    ["<M-K>"] = "<C-\\><C-n><c-w>k",
    ["<M-L>"] = "<C-\\><C-n><c-w>l",
    ["<M-N>"] = "<C-\\><C-n><c-w>p",
    ["<M-q>"] = "<C-\\><C-n>",
  },
  visual_mode = {},
  visual_block_mode = {
    ["ga"] = { "<Plug>(EasyAlign)", { noremap = false, silent = false } },
  },
  command_mode = {
    -- TODO: config this command for variable OSs.
    -- ['w!!'] = 'execute \'silent! write !sudo tee % >/dev/null\' <bar> edit!'
  },
}

M.hints = {
  ga = "EasyAlign",
  gb = { name = "Block comments", c = "Comment" },
  gc = {
    name = "Comments",
    A = "Append comment",
    c = "Comment",
    O = "Add comment line above",
    o = "Add comment line below",
  },
  gp = {
    name = "Preview",
    d = "Definition",
    i = "Implementations",
    r = "References",
  },
  gP = "Close preview window",

  ["[d"] = "Previous diagnostic",
  ["]d"] = "Next diagnostic",

  ["[h"] = "Previous hunk",
  ["]h"] = "Next hunk",

  ["[["] = "Previous class start",
  ["]["] = "Next class end",

  ["[]"] = "Previous class end",
  ["]]"] = "Next class start",
}

-- TODO: add visual mode hints.

-- TODO: check the difference between hints and operators.
-- TODO: add following operator hints.
-- gc{,A,c,O,o}
-- gb[,c]
M.wk_operators = { ga = "EasyAlign", gc = "Comments" }

return M
