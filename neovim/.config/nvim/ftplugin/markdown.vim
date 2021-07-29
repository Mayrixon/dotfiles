lua << EOF
local wk = require('which-key')

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
EOF
