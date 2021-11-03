local M = {}

function M.setup()
  require('neorg').setup {
    load = {
      ['core.defaults'] = {},
      ['core.integrations.telescope'] = {},
      ['core.integrations.treesitter'] = {},
      ['core.keybinds'] = {
        config = {default_keybinds = true, neorg_leader = '<Leader>e'}
      },
      ['core.norg.completion'] = {config = {engine = 'nvim-cmp'}},
      ['core.norg.concealer'] = {},
      ['core.norg.dirman'] = {
        config = {
          autochangedir = true,
          autodetact = true,
          workspaces = {my_workspace = '~/neorg'}
        }
      }
    }
  }

  -- NEORG KEYBINDS

  local neorg_callbacks = require('neorg.callbacks')
  neorg_callbacks.on_event('core.keybinds.events.enable_keybinds',
                           function(_, content)

    if content.mode == 'special-mode' then
      content.map('n', '<C-s>', ':w<CR>', {silent = true})
    end

    content.map_to_mode('special-mode', {n = {{'<C-s>', ':w<CR>'}}},
                        {silent = true})

    -- Keys for managing TODO items and setting their states
    content.map_event_to_mode('norg', {
      n = {
        {'gtd', 'core.norg.qol.todo_items.todo.task_done'},
        {'gtu', 'core.norg.qol.todo_items.todo.task_undone'},
        {'gtp', 'core.norg.qol.todo_items.todo.task_pending'},
        {'<C-Space>', 'core.norg.qol.todo_items.todo.task_cycle'}
      }
    }, {silent = true, noremap = true})

    -- Map all the below keybinds only when the "norg" mode is active
    content.map_event_to_mode('norg', {
      n = { -- Bind keys in normal mode
        {'<C-s>', 'core.integrations.telescope.find_linkable'}
      },

      i = { -- Bind in insert mode
        {'<C-l>', 'core.integrations.telescope.insert_link'}
      }
    }, {silent = true, noremap = true})

  end)
end

return M
