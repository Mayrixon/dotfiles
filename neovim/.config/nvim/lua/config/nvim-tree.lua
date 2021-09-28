-- TODO: pay attention to upcoming updates. -- on 2021-09-26
local M = {}

function M.setup()
  require('nvim-tree').setup({
    -- disables netrw completely
    disable_netrw = false,
    -- hijack netrw window on startup
    hijack_netrw = true,
    -- open the tree when running this setup function
    open_on_setup = false,
    -- will not open on setup if the filetype is in this list
    ignore_ft_on_setup = {},
    -- closes neovim automatically when the tree is the last **WINDOW** in the view
    auto_close = false,
    -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
    open_on_tab = false,
    -- hijack the cursor in the tree to put it at the start of the filename
    hijack_cursor = false,
    -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
    update_cwd = true,
    -- show lsp diagnostics in the signcolumn
    lsp_diagnostics = true,
    -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    update_focused_file = {
      -- enables the feature
      enable = true,
      -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
      -- only relevant when `update_focused_file.enable` is true
      update_cwd = false,
      -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
      -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
      ignore_list = {}
    },
    -- configuration options for the system open command (`s` in the tree by default)
    system_open = {
      -- the command to run this, leaving nil should work in most cases
      cmd = nil,
      -- the command arguments as a list
      args = {}
    },
    view = {
      -- width of the window, can be either a number (columns) or a string in `%`
      width = 30,
      -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
      side = 'left',
      -- if true the tree will resize itself after opening a file
      auto_resize = false,
      mappings = {
        -- custom only false will merge the list with the default mappings
        -- if true, it will only use your list to set the mappings
        custom_only = false,
        -- list of mappings to set on the tree manually
        list = {}
      }
    }
  })

  vim.g.nvim_tree_quit_on_open = 1 -- 0 by default, closes the tree when you open a file
  vim.g.nvim_tree_indent_markers = 1 -- 0 by default, this option shows indent markers when folders are open
  vim.g.nvim_tree_git_hl = 1 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
  vim.g.nvim_tree_highlight_opened_files = 1 -- 0 by default, will enable folder and file icon highlight for opened files/directories.
  vim.g.nvim_tree_add_trailing = 1 -- 0 by default, append a trailing slash to folder names
  vim.g.nvim_tree_group_empty = 1 -- 0 by default, compact folders that only contain a single folder into one node in the file tree
  vim.g.nvim_tree_special_files = {
    ['Readme.md'] = 1,
    ['readme.md'] = 1,
    ['README.md'] = 1,
    ['Makefile'] = 1,
    ['MAKEFILE'] = 1
  } -- List of filenames that gets highlighted with NvimTreeSpecialFile
end
return M
