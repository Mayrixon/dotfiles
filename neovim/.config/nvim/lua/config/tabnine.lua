local M = {}

function M.setup()
  local tabnine = require("cmp_tabnine.config")
  tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = false,
    snippet_placeholder = "..",
  })
end

return M
