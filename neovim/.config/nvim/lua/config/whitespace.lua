local M = {}

function M.setup()
  vim.g.better_whitespace_ctermcolor = "Gray"
  vim.g.better_whitespace_guicolor = "Gray"

  vim.g.better_whitespace_enabled = 1
  vim.g.strip_whitespace_on_save = 1
  vim.g.strip_only_modified_lines = 1

  vim.g.better_whitespace_operator = ""

  vim.g.better_whitespace_filetypes_blacklist = {
    "<filetype1>",
    "<filetype2>",
    "<etc>",
    "diff",
    "git",
    "gitcommit",
    "qf",
    "help",
    "fugitive",
    "terminal",
    "NvimTree",
    "TelescopePrompt",
  }
end

return M
