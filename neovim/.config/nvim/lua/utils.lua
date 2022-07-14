local M = {}

local telescope_ok, _ = pcall(require, "telescope")
if telescope_ok then
  M.telescope_cursor_theme = require("telescope.themes").get_cursor({
    layout_config = { width = 80, height = 14 },
  })

  M.telescope_dropdown_theme = require("telescope.themes").get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
    layout_config = { width = 120, height = 20 },
  })
else
  print("Missing telescope.")
end

function M.set_hover_on_diagnostics_autocmd()
  vim.api.nvim_create_augroup("LspCursorDiagnostics", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = "LspCursorDiagnostics",
    pattern = "*",
    callback = function()
      vim.diagnostic.open_float(0, { border = "rounded", focus = false, focusable = false, scope = "cursor" })
    end,
  })
end

return M
