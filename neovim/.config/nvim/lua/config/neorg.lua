local M = {}

function M.setup()
  require('neorg').setup {
    load = {
      ['core.defaults'] = {},
      ['core.integrations.telescope'] = {},
      ['core.keybinds'] = {
        config = {default_keybinds = true, neorg_leader = '<Leader>e'}
      },
      ['core.norg.completion'] = {config = {engine = 'nvim-cmp'}},
      ['core.norg.concealer'] = {},
      ['core.norg.dirman'] = {
        config = {workspaces = {my_workspace = '~/neorg'}}
      }
    }
  }
end

return M
