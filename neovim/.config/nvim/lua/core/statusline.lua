local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
  return
end

local navic_ok, navic = pcall(require, "nvim-navic")
if not navic_ok then
  return
end

local function paste_indicator()
  local indicator = ""

  if vim.o.paste == true then
    indicator = "PASTE"
  end

  return indicator
end

local function sleuth_indicator()
  return vim.fn.SleuthIndicator()
end

local function spell_indicator()
  local indicator = ""

  if vim.o.spell == true then
    indicator = "SPELL"
  end

  return indicator
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode", paste_indicator },
    lualine_b = {
      "branch",
      "diff",
      { "diagnostics", sources = { "nvim_diagnostic" } },
    },
    lualine_c = {
      "filename",
      -- INFO: move to winbar after nvim v0.8.
      { navic.get_location, cond = navic.is_available },
    },
    lualine_x = { spell_indicator, "encoding", "fileformat", "filetype", sleuth_indicator },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = {},
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  tabline = {
    lualine_a = { { "tabs", max_length = vim.o.columns / 1, mode = 2 } },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      { "filename", file_status = false, path = 1, shorting_target = 80 },
    },
  },
  extensions = { "fugitive", "nvim-dap-ui", "nvim-tree", "quickfix" },
})

-- local tabby_ok, tabby = pcall(require, "tabby")
-- if tabby_ok then
--   tabby.setup({
--     tabline = require("tabby.presets").tab_with_top_win,
--   })
-- else
--   print("Missing tabby.")
-- end

-- INFO: winbar will be available in neovim v0.8.
-- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
