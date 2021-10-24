local M = {}

function M.setup()
  vim.g.vimtex_fold_enabled = 1
  vim.g.vimtex_compiler_progname = 'nvr'
  vim.g.vimtex_compiler_latexmk = {
    ['options'] = {
      '-shell-escape', '-verbose', '-file-line-error', '-synctex=1',
      '-interaction=nonstopmode'
    }
  }
  vim.g.vimtex_quickfix_method = 'pplatex'
  vim.g.vimtex_quickfix_mode = 0

  if vim.fn.has('mac') ~= 0 then
    vim.g.vimtex_view_method = 'skim'
  else
    vim.g.vimtex_view_method = 'zathura'
  end

  vim.t.tex_flavor = 'latex'
end

return M
