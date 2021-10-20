local M = {}

local function paste_indicator()
  local indicator = ''

  if vim.o.paste == true then indicator = 'PASTE' end

  return indicator
end

local function sleuth_indicator() return vim.fn.SleuthIndicator() end

function M.setup()
  local gps = require('nvim-gps')

  require('lualine').setup({
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = {left = '', right = ''},
      section_separators = {left = '', right = ''},
      disabled_filetypes = {}
    },
    sections = {
      lualine_a = {'mode', paste_indicator},
      lualine_b = {
        'branch', 'diff', 'require(\'lsp-status\').status_progress()',
        {'diagnostics', sources = {'nvim_lsp', 'coc'}}
      },
      lualine_c = {'filename', {gps.get_location, cond = gps.is_available}},
      lualine_x = {'encoding', 'fileformat', 'filetype', sleuth_indicator},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    tabline = {
      lualine_a = {{'tabs', max_length = vim.o.columns / 1, mode = 2}},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {
        {'filename', file_status = false, path = 1, shorting_target = 80}
      }
    },
    extensions = {'fugitive', 'nvim-tree', 'quickfix'}
  })
end

return M
