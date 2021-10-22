-- TODO: add all functions into function setup()
local function colorscheme()
  vim.opt.cursorline = true

  vim.opt.background = 'dark'

  vim.g.gruvbox_italic = 1
  vim.cmd [[colorscheme gruvbox]]
end

local function provider_settings()
  vim.g.loaded_python_provider = 0
  vim.g.python3_host_prog = '/usr/bin/python3'

end

local function auto_cmds()
  -- Highlight on yank
  -- cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
  vim.cmd 'au TextYankPost * silent! lua vim.highlight.on_yank()'

  -- don't auto commenting new lines
  vim.cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

  -- Auto format
  -- vim.api.nvim_exec([[
  -- augroup auto_fmt
  --     autocmd!
  --     autocmd BufWritePre *.py,*.lua,*.rs try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
  -- aug END
  -- ]], false)

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

  -- TODO: check the whitespace plugin
  vim.api.nvim_exec([[
        fun! TrimWhitespace()
            let l:save = winsaveview()
            keeppatterns %s/\s\+$//e
            call winrestview(l:save)
        endfun
        "-- autocmd FileType * autocmd BufWritePre <buffer> call TrimWhitespace()
    ]], false)

  -- vim.cmd [[ autocmd CmdWinEnter * quit ]]

  vim.api.nvim_exec([[
      hi InactiveWindow guibg=#282C34
      autocmd VimEnter * set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
    ]], false)
end

local M = {}

function M.setup()
  colorscheme()
  provider_settings()
  -- auto_cmds()
end

return M
