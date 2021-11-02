local wk = require('which-key')

vim.g.markdown_fenced_languages = {'python', 'rust'}

wk.register({
  l = {
    name = 'Markdown',
    p = {
      name = 'preview',
      g = {'<Cmd>Glow<CR>', 'glow-preview'},
      p = {'<Cmd>MarkdownPreview<CR>', 'preview'},
      k = {'<Cmd>MarkdownPreviewStop<CR>', 'stop-preview'}
    }
  }
}, {prefix = '<localleader>', mode = 'n'})

wk.register({l = {name = 'Markdown'}}, {prefix = '<localleader>', mode = 'v'})
