require("packer_init")
require("core/options")
require("core/autocmds")
require("core/keymaps")
require("core/colors")
require("core/statusline")
require("lsp")

-- INFO: consider move to a system-based config file.
local function provider_settings()
  vim.g.loaded_python_provider = 0
  -- vim.g.python3_host_prog = '/usr/bin/python3'
end
