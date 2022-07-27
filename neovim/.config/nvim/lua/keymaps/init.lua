local leader_keys = require("keymaps.leader_keys")
local localleader_keys = require("keymaps.localleader_keys")
local lsp_keys = require("keymaps.lsp_keys")
local non_leader_keys = require("keymaps.non_leader_keys")
local opts = require("keymaps.opts")

local M = {
  --  dap_keys = dap_keys,
  leader_keys = leader_keys,
  localleader_keys = localleader_keys,
  lsp_keys = lsp_keys,
  non_leader_keys = non_leader_keys,
  opts = opts,
}

--- The function to get which-key register options.
-- @param wk_opts The options for which-key to register.
-- @param[opt=""] prefix The prefix of keybindings.
-- @param[opt=nil] bufnr The buffer number.
-- @return wk_opts The which-key register options.
function M.get_opts(wk_opts, prefix, bufnr)
  prefix = prefix or ""
  bufnr = bufnr or nil
  return vim.tbl_extend("force", wk_opts, { prefix = prefix, buffer = bufnr })
end

return M
