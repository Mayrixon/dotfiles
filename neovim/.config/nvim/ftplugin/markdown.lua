local wk = require('which-key')

vim.g.markdown_fenced_languages = {'python', 'rust'}

wk.register({
  l = {
    name = 'markdown',
    p = {
      name = 'preview',
      g = {'<cmd>Glow<CR>', 'glow-preview'},
      p = {'<cmd>MarkdownPreview<CR>', 'preview'},
      k = {'<cmd>MarkdownPreviewStop<CR>', 'stop-preview'}
    }
  }
}, {prefix = '<localleader>'})
