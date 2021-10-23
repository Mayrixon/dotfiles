-- TODO: rename
local function set_keymap_1(bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = {noremap = true, silent = true}

  local keybindings = require('keymappings').lsp_keys.non_leader.normal_mode

  for key, binding in pairs(keybindings) do
    buf_set_keymap('n', key, binding, opts)
  end
end

-- TODO: rename
local function set_keymap_2(client, bufnr)
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

local M = {set_keymap_1 = set_keymap_1, set_keymap_2 = set_keymap_2}

return M
