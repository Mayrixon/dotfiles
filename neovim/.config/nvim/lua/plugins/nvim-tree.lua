local M = {}

function M.setup()
  require("nvim-tree").setup({
    actions = { open_file = { quit_on_open = true, resize_window = false } },
    sync_root_with_cwd = true,
    diagnostics = { enable = true, show_on_dirs = true },
    renderer = {
      add_trailing = true,
      group_empty = true,
      highlight_git = true,
      highlight_opened_files = "name",
      indent_markers = { enable = true },
      special_files = {
        "Cargo.toml",
        "MAKEFILE",
        "Makefile",
        "README.md",
        "Readme.md",
        "readme.md",
      },
    },
    -- Configs for plugin project.
    respect_buf_cwd = true,
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
  })
end

return M
