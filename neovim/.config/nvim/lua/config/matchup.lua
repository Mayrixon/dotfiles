local M = {}

function M.setup()
  -- TODO: determine if this feature should be disabled after the settings of the status line.
  -- INFO: test file: kilo.c line 141 "else if"
  -- vim.g.matchup_matchparen_offscreen = {}

  vim.cmd [[
    augroup matchup_matchparen_disable_ft
      autocmd!
      autocmd FileType tex let [b:matchup_matchparen_fallback,
        \ b:matchup_matchparen_enabled] = [0, 0]
    augroup END

    augroup match_up_matchparen_disable_win
      autocmd!
      autocmd CmdWinEnter * let b:matchup_enabled = 0
    augroup END
  ]]
end

return M
