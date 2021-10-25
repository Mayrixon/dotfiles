local function colorscheme()
  vim.opt.cursorline = true

  vim.opt.background = 'dark'

  vim.g.gruvbox_italic = 1
  vim.cmd [[colorscheme gruvbox]]
end

-- INFO: consider move to a system-based config file.
local function provider_settings()
  vim.g.loaded_python_provider = 0
  vim.g.python3_host_prog = '/usr/bin/python3'
end

local function auto_cmds()
  -- Highlight on yank
  vim.cmd 'au TextYankPost * silent! lua vim.highlight.on_yank()'

  -- don't auto commenting new lines
  vim.cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

  vim.api.nvim_exec([[
        augroup auto_html
            autocmd!
            autocmd Filetype html setlocal ts=2 sw=2 expandtab
            autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 noexpandtab
        augroup END
    ]], false)

  vim.api.nvim_exec([[
        augroup auto_term
            autocmd!
            autocmd TermOpen * setlocal nonumber norelativenumber
            autocmd TermOpen * startinsert
        augroup END
    ]], false)
end

local M = {}

function M.setup()
  colorscheme()
  provider_settings()
  auto_cmds()
end

return M
