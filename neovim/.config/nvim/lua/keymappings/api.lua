local M = {}
-- TODO: resolve loop loading.
-- local keymappings = require('keymappings')

-- TODO: rename
function M.set_keymap_1(bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = {noremap = true, silent = true}

  local keybindings = require('keymappings').lsp_keys.non_leader.normal_mode

  for key, binding in pairs(keybindings) do
    buf_set_keymap('n', key, binding, opts)
  end
end

-- TODO: rename
function M.set_keymap_2(client, bufnr)
  local wk = require('which-key')

  -- TODO: remove
  local n_opts = {mode = 'n', buffer = bufnr, prefix = '<leader>'}
  local v_opts = {mode = 'v', buffer = bufnr, prefix = '<leader>'}

  local n_mappings = require('keymappings').lsp_keys.leader.normal_mode
  local v_mappings = require('keymappings').lsp_keys.leader.normal_mode

  wk.register(n_mappings, n_opts)
  wk.register(v_mappings, v_opts)

  -- TODO: change to tables
  if client.resolved_capabilities.document_range_formatting then
    wk.register({
      lF = {function() vim.lsp.buf.range_formatting() end, 'Range format'}
    }, v_opts)
  end
end

local wk = require('which-key')

local function get_prefix_opts(prefix, opts)
  return vim.tbl_extend('force', opts, {prefix = prefix})
end

local function set_other_operator_hints()
  local hints = require('keymappings').non_leader_keys.hints
  wk.register(hints, {prefix = ''})
end

function M.set_wk_keys()
  local n_opts = require('keymappings').opts.leader.normal
  local v_opts = require('keymappings').opts.leader.visual

  local leader_n_mappings = require('keymappings').leader_keys.normal_mappings
  local leader_v_mappings = require('keymappings').leader_keys.visual_mappings

  local localleader_n_mappings = require('keymappings').localleader_keys
                                     .normal_mappings
  -- TODO: move to keymappings.
  wk.register(leader_n_mappings, get_prefix_opts('<leader>', n_opts))
  wk.register(leader_v_mappings, get_prefix_opts('<leader>', v_opts))
  wk.register(localleader_n_mappings, get_prefix_opts('<localleader>', n_opts))
  set_other_operator_hints()
end

return M
