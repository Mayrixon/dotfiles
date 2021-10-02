-- TODO: check LSP mappings
-- TODO: Determine if LSP mappings list here or in LSP configs.
-- TODO: use plugin Trouble or Telescope instead of LSP list window
local M = {}

local opts = {noremap = true, silent = true}

local generic_opts = {
  insert_mode = opts,
  normal_mode = opts,
  visual_mode = opts,
  visual_block_mode = opts,
  command_mode = opts,
  term_mode = {silent = false}
}

local mode_adapters = {
  insert_mode = 'i',
  normal_mode = 'n',
  term_mode = 't',
  visual_mode = 'v',
  visual_block_mode = 'x',
  command_mode = 'c'
}

local keymappings = {
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

local lsp_keymappings = {
  normal_mode = {
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
}
-- local lsp_keymappings = {

--   normal_mode = {
--     ['K'] = '<Cmd>lua vim.lsp.buf.hover()<CR>',
--     ['gD'] = '<Cmd>lua vim.lsp.buf.declaration()<CR>',
--     ['gd'] = '<Cmd>lua vim.lsp.buf.definition()<CR>',
--     ['gi'] = '<Cmd>lua vim.lsp.buf.implementation()<CR>',
--     ['<C-k>'] = '<Cmd>lua vim.lsp.buf.signature_help()<CR>',
--     ['[d'] = '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
--     [']d'] = '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
--     ['[e'] = '<Cmd>Lspsaga diagnostic_jump_next<CR>',
--     [']e'] = '<Cmd>Lspsaga diagnostic_jump_prev<CR>'
--   }
-- }

local function set_keymaps(mode, key, val)
  local opt = generic_opts[mode] and generic_opts[mode] or opts
  if type(val) == 'table' then
    opt = val[2]
    val = val[1]
  end
  vim.api.nvim_set_keymap(mode, key, val, opt)
end

local function map(mode, keymaps)
  mode = mode_adapters[mode] and mode_adapters[mode] or mode
  for k, v in pairs(keymaps) do set_keymaps(mode, k, v) end
end

function M.setup()
  for mode, mapping in pairs(keymappings) do map(mode, mapping) end
end

-- function M.setup_lsp_mappings()
--   for mode, mapping in pairs(lsp_keymappings) do map(mode, mapping) end
-- end

-- INFO: remove temporary API
M.lsp_keymappings = lsp_keymappings

return M
