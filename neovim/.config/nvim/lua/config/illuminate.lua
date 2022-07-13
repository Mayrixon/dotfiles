local M = {}

function M.setup()
  vim.api.nvim_set_keymap(
    "n",
    "<a-n>",
    '<Cmd>lua require"illuminate".next_reference{wrap=true}<CR>',
    { noremap = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<a-p>",
    '<Cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>',
    { noremap = true }
  )
  vim.g.Illuminate_ftblacklist = { "nerdtree" }
end

return M
