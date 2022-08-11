local M = {}

function M.setup()
  require("sniprun").setup({
    display = {
      "Classic",
      "VirtualTextOk",
      "LongTempFloatingWindow",
    },
  })
end

return M
