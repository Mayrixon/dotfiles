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
  -- TODO: move to keymappings/non_leader.
  -- TODO: add g, [, and ]
  wk.register({
    -- TODO: LSP-enabled only. buffer in opts would be useful
    gd = 'Definition',
    gl = 'LSP finder',

    ga = 'EasyAlign',
    gc = 'Comments',

    ['[d'] = 'Previous diagnostic',
    [']d'] = 'Next diagnostic'

  }, {prefix = ''})
end

function M.setup()
  wk.setup({
    operators = {ga = 'EasyAlign', gc = 'Comments'},
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
