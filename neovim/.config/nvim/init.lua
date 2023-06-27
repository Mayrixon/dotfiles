-- TODO: add local configs
-- local local_config = require(local_config)
-- TODO: add to a system-based config file.
-- local function provider_settings()
--   vim.g.loaded_python_provider = 0
--   -- vim.g.python3_host_prog = '/usr/bin/python3'
-- end

require("config")

-- TODO: move lines underneth to other places
vim.opt.background = "dark"

-- local lsp_highlight_color = { link = "GruvboxGreenUnderline" }

vim.cmd.colorscheme("gruvbox")
