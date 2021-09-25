local M = {}
local cmp = require('cmp')

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
             vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
                 :match('%s') == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true),
                        mode, true)
end

function M.setup()
  cmp.setup({
    completion = {completeopt = 'menu,menuone,noselect'},
    formatting = {
      format = function(entry, vim_item)
        -- fancy icons and a name of kind
        vim_item.kind =
            require('lspkind').presets.default[vim_item.kind] .. ' ' ..
                vim_item.kind
        -- set a name for each source
        vim_item.menu = ({
          buffer = '[Buffer]',
          nvim_lsp = '[LSP]',
          ultisnips = '[UltiSnips]',
          nvim_lua = '[Lua]',
          cmp_tabnine = '[TabNine]',
          look = '[Look]',
          path = '[Path]',
          spell = '[Spell]',
          calc = '[Calc]',
          emoji = '[Emoji]',
          treesitter = '[treesitter]',
          neorg = '[Neorg]'
        })[entry.source.name]
        return vim_item
      end
    },
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      -- ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      -- BUG: change logic to: if not select anything, press <CR> don't complete.
      -- Tryed but not working. Use <C-Space> to exit complete first.
      -- INFO: It seems the bug caused by ultisnips.
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false
      }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          feedkey('<C-n>', 'n')
        elseif vim.fn['UltiSnips#CanJumpForwards']() == 1 then
          feedkey('<ESC>:call UltiSnips#JumpForwards()<CR>', '')
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {'i', 's'}),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          feedkey('<C-p>', 'n')
        elseif vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
          return feedkey('<C-R>=UltiSnips#JumpBackwards()<CR>')
        else
          fallback()
        end
      end, {'i', 's'}),
      ['<C-Space>'] = cmp.mapping(function(fallback)

        if vim.fn.pumvisible() == 1 then
          if vim.fn.complete_info()['selected'] == -1 then
            feedkey('<C-e>', 'n')
          else
            if vim.fn['UltiSnips#CanExpandSnippet']() == 1 then
              feedkey('<C-R>=UltiSnips#ExpandSnippet()<CR>', '')
            else
              cmp.complete()
            end
          end
        else
          fallback()
        end
      end, {'i', 's'})
    },
    snippet = {expand = function(args) vim.fn['UltiSnips#Anon'](args.body) end},
    sources = {
      {name = 'buffer'}, {name = 'nvim_lsp'}, {name = 'ultisnips'},
      {name = 'nvim_lua'}, {name = 'path'}, {name = 'emoji'},
      {name = 'treesitter'}, {name = 'look'}, {name = 'calc'}, {name = 'spell'},
      {name = 'neorg'}
      -- {name = 'cmp_tabnine'}
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
