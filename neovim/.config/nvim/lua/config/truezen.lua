local M = {}

function M.setup()
  local true_zen = require("true-zen")

  true_zen.setup({
    ui = {
      bottom = {
        laststatus = 0,
        ruler = false,
        showmode = false,
        showcmd = false,
        cmdheight = 1,
      },
      top = { showtabline = 0 },
      left = { number = false, relativenumber = false, signcolumn = "no" },
    },
    modes = {
      ataraxis = {
        left_padding = 32,
        right_padding = 32,
        top_padding = 1,
        bottom_padding = 1,
        ideal_writing_area_width = { 0 },
        auto_padding = true,
        keep_default_fold_fillchars = true,
        custom_bg = { "none", "" },
        bg_configuration = true,
        quit = "untoggle",
        ignore_floating_windows = true,
        affected_higroups = {},
      },
      focus = { margin_of_error = 5, focus_method = "experimental" },
    },
    integrations = {
      vim_gitgutter = false,
      galaxyline = false,
      tmux = true,
      gitsigns = true,
      nvim_bufferline = false,
      limelight = false,
      twilight = true,
      vim_airline = false,
      vim_powerline = false,
      vim_signify = false,
      express_line = false,
      lualine = false,
      lightline = false,
      feline = false,
    },
    misc = {
      on_off_commands = false,
      ui_elements_commands = false,
      cursor_by_mode = true,
    },
  })

  true_zen.after_mode_ataraxis_on = function()
    vim.opt_local.scrolloff = 999
    vim.opt_local.linebreak = true

    vim.cmd([[
      map j gj
      map k gk
    ]])

    require("cmp").setup.buffer({ enabled = false })
    require("config.lsp.utils").disable_diagnostics()
    vim.cmd([[
      DisableWhitespace
    ]])
  end

  true_zen.before_mode_ataraxis_off = function()
    vim.opt_local.scrolloff = -1
    vim.opt_local.linebreak = vim.opt.linebreak:get()

    vim.cmd([[
      unmap j
      unmap k
    ]])

    require("cmp").setup.buffer({ enabled = true })
    require("config.lsp.utils").enable_diagnostics()
    vim.cmd([[
      EnableWhitespace
    ]])
  end
end

return M
