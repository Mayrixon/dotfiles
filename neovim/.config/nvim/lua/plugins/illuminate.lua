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
  vim.g.Illuminate_ftblacklist = { "NvimTree", "terminal" }
  vim.g.Illuminate_highlightUnderCursor = 0

  vim.cmd([[
  augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi link illuminatedWord GruvboxGreenUnderline
  augroup END
  ]])
end

return M
