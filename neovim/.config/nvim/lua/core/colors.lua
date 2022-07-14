local status_ok, gruvbox = pcall(require, "gruvbox")
if not status_ok then
  return
end

vim.opt.background = "dark"

local lsp_highlight_color = { link = "GruvboxGreenUnderline" }

gruvbox.setup({
  overrides = {
    LspReferenceText = lsp_highlight_color,
    LspReferenceWrite = lsp_highlight_color,
    LspReferenceRead = lsp_highlight_color,
  },
})
vim.cmd([[colorscheme gruvbox]])
