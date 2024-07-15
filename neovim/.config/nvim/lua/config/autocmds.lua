-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

--------------------------- Modified LazyVim's autocmds ------------------------
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "oil",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})
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
  group = vim.aip.nvim_create_augroup("PlaintextFormats"),
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
