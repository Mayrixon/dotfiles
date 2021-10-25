local function set_lsp_non_leader_mappings(bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = {noremap = true, silent = true}

  local keybindings = require('keymappings').lsp_keys.non_leader.normal_mode

  for key, binding in pairs(keybindings) do
    buf_set_keymap('n', key, binding, opts)
  end
end

local function set_lsp_leader_mappings(bufnr)
  local wk = require('which-key')

  local keymappings = require('keymappings')
  local utils = require('keymappings.utils')

  wk.register(keymappings.lsp_keys.leader.normal_mode,
              utils.get_buffer_opts(bufnr,
                                    utils.get_prefix_opts('<leader>',
                                                          keymappings.opts
                                                              .leader.normal)))
  wk.register(keymappings.lsp_keys.leader.visual_mode,
              utils.get_buffer_opts(bufnr,
                                    utils.get_prefix_opts('<leader>',
                                                          keymappings.opts
                                                              .leader.visual)))

end
local function set_lsp_capability_mappings(client)
  local wk = require('which-key')

  local keymappings = require('keymappings')
  local utils = require('keymappings.utils')

  for _, m in pairs(keymappings.lsp_keys.capability_mappings) do
    local capability, key, prefix, mode = unpack(m)
    if client.resolved_capabilities[capability] then
      wk.register(key,
                  utils.get_prefix_opts(prefix, keymappings.opts.leader[mode]))
    end
  end
end

local M = {}

function M.set_lsp_keymap(client, bufnr)
  set_lsp_non_leader_mappings(bufnr)
  set_lsp_leader_mappings(bufnr)
  set_lsp_capability_mappings(client)
end

return M
