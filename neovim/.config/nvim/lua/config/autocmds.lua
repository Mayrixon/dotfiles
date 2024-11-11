-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

--------------------------- Modified LazyVim's autocmds ------------------------
------------------------------- End modification -------------------------------

vim.api.nvim_create_autocmd({ "VimEnter", "InsertLeave" }, {
  desc = "set relativenumber",
  group = vim.api.nvim_create_augroup("set_relativenumber", { clear = true }),
  pattern = "*.*",
  command = "set relativenumber",
})

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  desc = "set number",
  group = vim.api.nvim_create_augroup("set_number", { clear = true }),
  pattern = "*",
  command = "set number norelativenumber",
})

vim.api.nvim_create_autocmd("Filetype", {
  group = vim.api.nvim_create_augroup("PlaintextFormats", { clear = true }),
  pattern = { "tex", "text", "markdown" },
  callback = function()
    vim.keymap.set({ "n", "v" }, "j", "gj", { silent = true, buffer = true })
    vim.keymap.set({ "n", "v" }, "k", "gk", { silent = true, buffer = true })
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
  end,
})
