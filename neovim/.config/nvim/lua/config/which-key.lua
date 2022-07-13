local wk = require("which-key")
local keymappings = require("keymappings")

local M = {}

function M.setup()
  local wk_operators = keymappings.non_leader_keys.wk_operators
  wk.setup({
    operators = wk_operators,
    key_labels = {
      ["<space>"] = "<Space>",
      ["<cr>"] = "<CR>",
      ["<tab>"] = "<Tab>",
    },
  })
end

return M
