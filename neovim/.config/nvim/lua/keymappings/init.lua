local M = {}

local opts = {noremap = true, silent = true}

local generic_opts = {
  insert_mode = opts,
  normal_mode = opts,
  visual_mode = opts,
  visual_block_mode = opts,
  command_mode = opts,
  term_mode = {silent = false}
}

local mode_adapters = {
  insert_mode = 'i',
  normal_mode = 'n',
  term_mode = 't',
  visual_mode = 'v',
  visual_block_mode = 'x',
  command_mode = 'c'
}

local keymappings = require('keymappings.non_leader_keys').mappings

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

M.api = require('keymappings.api')
M.leader_keys = require('keymappings.leader_keys')
M.localleader_keys = require('keymappings.localleader_keys')
M.lsp_keys = require('keymappings.lsp_keys')
M.non_leader_keys = require('keymappings.non_leader_keys')

return M
