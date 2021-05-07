local utils = { }

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

--- Set vim options.
-- For any scope value inputted, the global value will also be setted.
-- @param scope String in the range of {o, b, w}.
-- @param key String of the key.
-- @param value Any kind of desire value.
function utils.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

function utils.map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return utils
