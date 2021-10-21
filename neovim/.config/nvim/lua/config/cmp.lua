local M = {}

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
             vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
                 :match('%s') == nil
end

function M.setup()
  local cmp = require('cmp')
  local lspkind = require('lspkind')
  local luasnip = require('luasnip')

  cmp.setup({
    completion = {completeopt = 'menu,menuone,noselect'},
    formatting = {
      format = lspkind.cmp_format({
        with_text = true,
        -- preset = 'codicons',
        menu = ({
          buffer = '[Buffer]',
          nvim_lsp = '[LSP]',
          luasnip = '[LuaSnip]',
          nvim_lua = '[Lua]',
          latex_symbols = '[LaTeX]',
          cmp_tabnine = '[TabNine]',
          look = '[Look]',
          path = '[Path]',
          spell = '[Spell]',
          calc = '[Calc]',
          emoji = '[Emoji]',
          treesitter = '[treesitter]',
          neorg = '[Neorg]'
        })
      })
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = false
      }),

      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {'i', 's'}),

      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {'i', 's'})
    },
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args) require('luasnip').lsp_expand(args.body) end
    },
    sources = {
      {name = 'buffer'}, {name = 'nvim_lsp'}, {name = 'luasnip'},
      {name = 'nvim_lua'}, {name = 'path'},
      {name = 'emoji', max_item_count = 5}, {name = 'treesitter'},
      {name = 'look', max_item_count = 5}, {name = 'calc'},
      {name = 'spell', max_item_count = 5}, {name = 'neorg'},
      {name = 'cmp_tabnine'}
    }
  })

  require('nvim-autopairs.completion.cmp').setup({
    map_cr = true, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
    auto_select = true, -- automatically select the first item
    insert = false -- use insert confirm behavior instead of replace
  })
end

return M
-- TODO: refac export
