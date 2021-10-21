local M = {}

local cmd = vim.cmd
local opt = vim.opt
local indent = 4

function M.setup()
  cmd 'syntax enable'
  cmd 'filetype plugin indent on'

  opt.timeoutlen = 1000
  opt.updatetime = 500

  opt.mouse = 'a'

  opt.hidden = true

  opt.display = 'msgsep'

  opt.ignorecase = true
  opt.smartcase = true
  opt.inccommand = 'split'

  opt.termguicolors = true
  opt.breakindent = true
  opt.lazyredraw = true

  opt.wildmode = 'longest,full'

  opt.showmatch = true

  opt.scrolloff = 4
  opt.sidescrolloff = 4

  opt.listchars = 'tab:> ,trail:-,extends:>,precedes:<,nbsp:+'
  opt.list = true

  opt.number = true
  opt.relativenumber = true
  opt.signcolumn = 'yes'

  opt.foldmethod = 'syntax'

  opt.conceallevel = 1
  opt.concealcursor = 'nc'

  opt.expandtab = true
  opt.smartindent = true
  opt.shiftwidth = indent
  opt.tabstop = indent

  opt.pumblend = 12

  opt.formatoptions =
      opt.formatoptions - 't' -- Don't auto format my code. I got linters for that.
      + 'c' -- In general, I like it when comments respect textwidth
      + 'r' -- Insert comment after <Enter>
      - 'o' -- O and o, don't continue comments
      + 'q' -- Allow formatting comments with gq
      - 'w' -- Trailing white space don't indicate continuing paragraph.
      - 'a' -- Auto formatting is BAD.
      + 'n' -- Indent past the formatlistpat, not underneath it.
      - '2' -- I'm not in gradeschool anymore
      + 'j' -- Auto-remove comments if possible.

end

return M
-- TODO: refac export
