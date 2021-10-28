local api = require('keymappings.api')
local dap_keys = require('keymappings.dap_keys')
local leader_keys = require('keymappings.leader_keys')
local localleader_keys = require('keymappings.localleader_keys')
local lsp_keys = require('keymappings.lsp_keys')
local non_leader_keys = require('keymappings.non_leader_keys')
local opts = require('keymappings.opts')
local utils = require('keymappings.utils')

local function set_keymaps(mode, key, val)
  local opt = opts.generic_opts[mode] and opts.generic_opts[mode] or
                  opts.fallback_opts
  if type(val) == 'table' then
    opt = val[2]
    val = val[1]
  end
  vim.api.nvim_set_keymap(mode, key, val, opt)
end

local function map(mode, keymaps)
  mode = opts.mode_adapters[mode] and opts.mode_adapters[mode] or mode
  for k, v in pairs(keymaps) do set_keymaps(mode, k, v) end
end

local function set_non_leader_keys()
  for mode, mapping in pairs(non_leader_keys.mappings) do map(mode, mapping) end
end

local function set_wk_keys()
  local wk = require('which-key')

  local n_opts = opts.leader.normal
  local v_opts = opts.leader.visual

  wk.register(leader_keys.normal_mappings,
              utils.get_prefix_opts('<leader>', n_opts))
  wk.register(leader_keys.visual_mappings,
              utils.get_prefix_opts('<leader>', v_opts))

  wk.register(localleader_keys.normal_mappings,
              utils.get_prefix_opts('<localleader>', n_opts))
  wk.register(localleader_keys.visual_mappings,
              utils.get_prefix_opts('<localleader>', v_opts))

  wk.register(non_leader_keys.hints)
end

local M = {
  api = api,
  dap_keys = dap_keys,
  lsp_keys = lsp_keys,
  non_leader_keys = non_leader_keys,
  opts = opts
}

function M.setup()
  set_wk_keys()
  set_non_leader_keys()
end

return M
