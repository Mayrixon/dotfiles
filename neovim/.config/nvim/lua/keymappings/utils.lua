local M = {}

function M.get_prefix_opts(prefix, opts)
  return vim.tbl_extend('force', opts, {prefix = prefix})
end

function M.get_buffer_opts(bufnr, opts)
  return vim.tbl_extend('force', opts, {buffer = bufnr})
end

return M
