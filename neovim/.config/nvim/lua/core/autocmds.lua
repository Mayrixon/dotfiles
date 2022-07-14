local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch" })
  end,
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- Set indentation to 2 spaces
augroup("setIndent", { clear = true })
autocmd("Filetype", {
  group = "setIndent",
  pattern = { "xml", "html", "xhtml", "css", "scss", "javascript", "typescript", "yaml", "lua" },
  command = "setlocal shiftwidth=2 tabstop=2",
})

-- Terminal settings:
augroup("autoTerm", { clear = true })

-- Enter insert mode when switching to terminal
autocmd("TermOpen", {
  group = "autoTerm",
  command = "setlocal listchars= nonumber norelativenumber nocursorline",
})

autocmd("TermOpen", {
  group = "autoTerm",
  pattern = "*",
  command = "startinsert",
})

-- Close terminal buffer on process exit
autocmd("BufLeave", {
  group = "autoTerm",
  pattern = "term://*",
  command = "stopinsert",
})

-- Display details when hovering on diagnostics
require("utils").set_hover_on_diagnostics_autocmd()
