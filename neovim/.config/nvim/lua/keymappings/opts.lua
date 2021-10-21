local M = {}

local opts = {noremap = true, silent = true}

M.generic_opts = {
  insert_mode = opts,
  normal_mode = opts,
  visual_mode = opts,
  visual_block_mode = opts,
  command_mode = opts,
  term_mode = {silent = false}
}

M.mode_adapters = {
  insert_mode = 'i',
  normal_mode = 'n',
  term_mode = 't',
  visual_mode = 'v',
  visual_block_mode = 'x',
  command_mode = 'c'
}

M.leader = {
  normal = {
    mode = 'n',
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true
  },

  visual = {
    mode = 'v',
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true
  }
}

return M
