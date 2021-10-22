local fallback_opts = {noremap = true, silent = true}

local M = {}

M.opts = fallback_opts

M.generic_opts = {
  insert_mode = fallback_opts,
  normal_mode = fallback_opts,
  visual_mode = fallback_opts,
  visual_block_mode = fallback_opts,
  command_mode = fallback_opts,
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
