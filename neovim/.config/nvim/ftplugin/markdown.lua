local wk = require("which-key")

-- vim.g.markdown_fenced_languages = { "python", "rust", "tex" }

wk.register({
  l = {
    name = "Markdown",
    p = {
      name = "preview",
      g = { "<Cmd>Glow<CR>", "glow-preview" },
      p = { "<Cmd>MarkdownPreview<CR>", "preview" },
      k = { "<Cmd>MarkdownPreviewStop<CR>", "stop-preview" },
    },
  },
}, { prefix = "<localleader>", mode = "n" })

vim.cmd('vnoremap <localleader>lw :call mkdx#WrapText("v", "[[", "]]")<CR>')

wk.register({ l = { name = "Markdown", w = { "Add wiki link" } } }, { prefix = "<localleader>", mode = "v" })
