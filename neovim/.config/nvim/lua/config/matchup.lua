local M = {}

function M.setup()
  vim.cmd([[
    augroup matchup_matchparen_disable_ft
      autocmd!
      autocmd FileType tex let [b:matchup_matchparen_fallback,
        \ b:matchup_matchparen_enabled] = [0, 0]
    augroup END

    augroup match_up_matchparen_disable_win
      autocmd!
      autocmd CmdWinEnter * let b:matchup_enabled = 0
    augroup END
  ]])
end

return M
