local api = require('keymappings.api')
local leader_keys = require('keymappings.leader_keys')
local localleader_keys = require('keymappings.localleader_keys')
local lsp_keys = require('keymappings.lsp_keys')
local non_leader_keys = require('keymappings.non_leader_keys')
local opts = require('keymappings.opts')

local fallback_opts = opts.opts

local generic_opts = opts.generic_opts

local mode_adapters = opts.mode_adapters

local keymappings = non_leader_keys.mappings

local function set_keymaps(mode, key, val)
  local opt = generic_opts[mode] and generic_opts[mode] or fallback_opts
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

local M = {
  api = api,
  leader_keys = leader_keys,
  localleader_keys = localleader_keys,
  lsp_keys = lsp_keys,
  non_leader_keys = non_leader_keys,
  opts = opts,

  set_wk_keys = api.set_wk_keys
}

function M.set_non_leader_keys()
  for mode, mapping in pairs(keymappings) do map(mode, mapping) end
end

return M
