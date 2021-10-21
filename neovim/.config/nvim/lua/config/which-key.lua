local M = {}

local wk = require('which-key')

local n_opts = {
  mode = 'n',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true
}

local v_opts = {
  mode = 'v',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true
}

local leader_n_mappings = require('keymappings').leader_keys.normal_mappings
local leader_v_mappings = require('keymappings').leader_keys.visual_mappings

local localleader_n_mappings = require('keymappings').localleader_keys
                                   .normal_mappings

local function get_prefix_opts(prefix, opts)
  return vim.tbl_extend('force', opts, {prefix = prefix})
end

local function set_other_operator_hints()
  local hints = require('keymappings').non_leader_keys.hints
  wk.register(hints, {prefix = ''})
end

function M.setup()
  local wk_operators = require('keymappings').non_leader_keys.wk_operators
  wk.setup({
    operators = wk_operators,
    key_labels = {
      ['<space>'] = '<Space>',
      ['<cr>'] = '<CR>',
      ['<tab>'] = '<Tab>'
    }
  })

  -- TODO: move to keymappings.
  wk.register(leader_n_mappings, get_prefix_opts('<leader>', n_opts))
  wk.register(leader_v_mappings, get_prefix_opts('<leader>', v_opts))
  wk.register(localleader_n_mappings, get_prefix_opts('<localleader>', n_opts))
  set_other_operator_hints()
end

return M
