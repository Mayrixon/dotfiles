local g = vim.g -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = "a"
opt.completeopt = "menuone,noinsert,noselect"
opt.timeoutlen = 1000
opt.pumblend = 12
opt.undofile = true

-- TODO: check the manual.
-- opt.formatoptions = opt.formatoptions
--   - "t" -- Don't auto format my code. I got linters for that.
--   + "c" -- In general, I like it when comments respect textwidth
--   + "r" -- Insert comment after <Enter>
--   - "o" -- O and o, don't continue comments
--   + "q" -- Allow formatting comments with gq
--   - "w" -- Trailing white space don't indicate continuing paragraph.
--   - "a" -- Auto formatting is BAD.
--   + "n" -- Indent past the formatlistpat, not underneath it.
--   - "2" -- I'm not in gradeschool anymore
--   + "j" -- Auto-remove comments if possible.

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.showmatch = true
opt.foldmethod = "syntax"
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"
opt.breakindent = true
opt.linebreak = true
opt.termguicolors = true
opt.list = true
opt.listchars = "tab:> ,trail:-,extends:>,precedes:<,nbsp:+"
opt.scrolloff = 4
opt.sidescrolloff = 4
opt.conceallevel = 1
opt.concealcursor = "nc"
opt.wildmode = "longest,full"

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true
opt.lazyredraw = true
opt.synmaxcol = 1000
opt.updatetime = 500
