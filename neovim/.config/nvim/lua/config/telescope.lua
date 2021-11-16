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
        n = {['<M-t>'] = trouble.open_with_trouble}
      }
    },
    extensions = {
      frecency = {
        workspaces = {
          ['dotfiles'] = home_dir .. 'dotfiles',
          ['notes'] = home_dir .. 'notes'
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

  telescope.load_extension('fzf')
  telescope.load_extension('frecency')
  telescope.load_extension('session-lens')
  telescope.load_extension('project')
end

-- TODO: move to user-define function file.
function M.find_project_files()
  local opts = {}
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end

M.cursor_theme = require('telescope.themes').get_cursor({
  layout_config = {width = 80, height = 14}
})

M.dropdown_theme = require('telescope.themes').get_dropdown({
  winblend = 10,
  border = true,
  previewer = false,
  shorten_path = false,
  layout_config = {width = 120, height = 20}
})
return M
