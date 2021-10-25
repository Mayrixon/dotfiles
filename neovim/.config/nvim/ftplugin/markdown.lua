local wk = require('which-key')

vim.g.markdown_fenced_languages = {'python', 'rust'}

wk.register({
  l = {
    name = 'Markdown',
    p = {
      name = 'preview',
      g = {'<cmd>Glow<CR>', 'glow-preview'},
      p = {'<cmd>MarkdownPreview<CR>', 'preview'},
      k = {'<cmd>MarkdownPreviewStop<CR>', 'stop-preview'}
    }
  }
}, {prefix = '<localleader>', mode = 'n'})

wk.register({l = {name = 'Markdown'}}, {prefix = '<localleader>', mode = 'v'})
