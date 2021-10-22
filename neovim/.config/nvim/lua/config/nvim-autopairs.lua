local M = {}

function M.setup()
  require('nvim-autopairs').setup({check_ts = true, fast_wrap = {map = '<M-e>'}})
end

return M
