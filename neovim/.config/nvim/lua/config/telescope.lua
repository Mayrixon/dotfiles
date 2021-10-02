-- TODO: check the theme settings.
local M = {}

function M.setup()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local trouble = require('trouble.providers.telescope')

  local home_dir = vim.env.HOME .. '/'

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-n>'] = actions.cycle_history_next,
          ['<C-p>'] = actions.cycle_history_prev,

          ['<M-t>'] = trouble.open_with_trouble
        },
        n = {['<c-t>'] = trouble.open_with_trouble}
      }
    },
    extensions = {
      arecibo = {
        ['selected_engine'] = 'google',
        ['url_open_command'] = 'open',
        ['show_http_headers'] = false,
        ['show_domain_icons'] = false
      },
      frecency = {
        workspaces = {
          ['dotfiles'] = home_dir .. 'dotfiles',
          ['neorg'] = home_dir .. 'neorg',
          ['org'] = home_dir .. 'org',
          ['wiki'] = home_dir .. 'wiki'
        }
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case'
      },
      tele_tebby = {use_highlighter = true}
    }
  })

  telescope.load_extension('arecibo')
  telescope.load_extension('fzf')
  telescope.load_extension('frecency')
  telescope.load_extension('session-lens')
  telescope.load_extension('project')
end

function M.find_project_files()
  local opts = {}
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end

return M
