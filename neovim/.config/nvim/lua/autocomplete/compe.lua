local utils = require('utils')

utils.opt('o', 'shortmess', vim.o.shortmess .. 'c')
utils.opt('o', 'completeopt', 'menuone,noselect')

require'compe'.setup {
  enabled = true,
  autocomplete = true,
  debug = false,

  source = {
    path = true,
    buffer = true,
    calc = true,
    vsnip = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    treesitter = true
  }
}

-- Set autopairs working with compe
require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true -- it will auto insert `(` after select function or method item
})

vim.cmd [[
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
]]

-- Map tab to navigate completion menu
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() ~= 0 then
    return t '<C-n>'
  elseif vim.fn.call('vsnip#available', {1}) == 1 then
    return t '<Plug>(vsnip-expand-or-jump)'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() ~= 0 then
    return t '<C-p>'
    -- elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    --     return t "<Plug>(vsnip-jump-prev)"
  else
    return t '<S-Tab>'
  end
end

utils.map('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
utils.map('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
utils.map('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
utils.map('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
