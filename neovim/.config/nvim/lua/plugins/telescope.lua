local trouble_ok, trouble = pcall(require, "trouble.providers.telescope")
if not trouble_ok then
  return
end

local M = {}

function M.setup()
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  local home_dir = vim.env.HOME .. "/"

  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<M-t>"] = trouble.open_with_trouble,
        },
        n = { ["<M-t>"] = trouble.open_with_trouble },
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({
          -- even more opts
        }),
      },
      frecency = {
        workspaces = {
          ["dotfiles"] = home_dir .. "dotfiles",
          ["notes"] = home_dir .. "notes",
        },
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      tele_tebby = { use_highlighter = true },
    },
  })

  telescope.load_extension("fzf")
  telescope.load_extension("frecency")
  telescope.load_extension("file_browser")
  telescope.load_extension("session-lens")
  telescope.load_extension("project")
  telescope.load_extension("ui-select")
end

return M
