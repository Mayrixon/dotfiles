local M = {}

M.api = require('keymappings.api')
M.leader_keys = require('keymappings.leader_keys')
M.localleader_keys = require('keymappings.localleader_keys')
M.lsp_keys = require('keymappings.lsp_keys')
M.non_leader_keys = require('keymappings.non_leader_keys')
M.opts = require('keymappings.opts')

local opts = M.opts.opts

local generic_opts = M.opts.generic_opts

local mode_adapters = M.opts.mode_adapters

local keymappings = M.non_leader_keys.mappings

local function set_keymaps(mode, key, val)
  local opt = generic_opts[mode] and generic_opts[mode] or opts
  if type(val) == 'table' then
    opt = val[2]
    val = val[1]
  end
  vim.api.nvim_set_keymap(mode, key, val, opt)
end

local function map(mode, keymaps)
  mode = mode_adapters[mode] and mode_adapters[mode] or mode
  for k, v in pairs(keymaps) do set_keymaps(mode, k, v) end
end

function M.setup()
  for mode, mapping in pairs(keymappings) do map(mode, mapping) end
end

return M
