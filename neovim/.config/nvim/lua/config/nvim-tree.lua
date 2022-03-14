-- INFO: pay attention to upcoming updates. -- on 2021-10-31
local M = {}

function M.setup()
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_highlight_opened_files = 1
  vim.g.nvim_tree_add_trailing = 1
  vim.g.nvim_tree_group_empty = 1
  vim.g.nvim_tree_special_files = {
    ['Readme.md'] = 1,
    ['readme.md'] = 1,
    ['README.md'] = 1,
    ['Cargo.toml'] = true,
    ['Makefile'] = 1,
    ['MAKEFILE'] = 1
  }

  require('nvim-tree').setup({
    actions = {open_file = {quit_on_open = true}},
    disable_netrw = false,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    auto_close = false,
    auto_reload_on_write = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    update_to_buf_dir = {enable = true, auto_open = true},
    diagnostics = {
      enable = true,
      icons = {hint = '', info = '', warning = '', error = ''}
    },
    update_focused_file = {enable = true, update_cwd = false, ignore_list = {}},
    system_open = {cmd = nil, args = {}},
    view = {
      width = 30,
      height = 30,
      hide_root_folder = false,
      side = 'left',
      auto_resize = false,
      mappings = {custom_only = false, list = {}}
    }
  })
end

return M
