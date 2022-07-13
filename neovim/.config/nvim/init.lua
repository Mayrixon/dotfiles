-- TODO: refactor plugin loading for better bootstrap experience.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local function sys_init()
  -- Performance
  require("impatient")
end

-------------------------------- Start loading ---------------------------------

require("defaults").setup()

require("plugins").setup()

sys_init()

require("keymappings").setup()

require("settings").setup()

require("config.lsp").setup()

require("config.dap").setup()

--------------------------------- End loading ----------------------------------
