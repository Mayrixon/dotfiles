local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
if not gitsigns_ok then
  print("Missing gitsigns.")
  return
end

local lint_ok, lint = pcall(require, "lint")
if not lint_ok then
  print("Missing lint.")
  return
end

local spectre_ok, spectre = pcall(require, "spectre")
if not spectre_ok then
  print("Missing spectre.")
  return
end

local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
  print("Missing telescope.")
  return
end

local utils = require("utils")

vim.cmd([[
  function! DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
      if getbufvar(buf, '&mod') == 0
      silent execute 'bwipeout' buf
      endif
    endfor
  endfunction
]])

vim.cmd([[
  function! Scratch()
    noswapfile hide enew
    setlocal buftype=nofile
    setlocal bufhidden=hide
  endfunction
]])

local M = {}

M.normal = {
  ["<Space>"] = { name = "EasyMotion" },

  ["?"] = { "<Cmd>Cheatsheet<CR>", "Cheat sheet" },

  b = {
    name = "Buffer",
    A = { "<Cmd>%bd|e#<CR>", "Delete all buffers" },
    a = { "<Cmd>Alpha<CR>", "Open Dashboard" },
    c = { "<Cmd>call DeleteHiddenBuffers()<CR>", "Clear all saved buffers" },
    d = { "<Cmd>bd<CR>", "Delete current buffer" },
    f = { "<Cmd>bd!<CR>", "Force delete current buffer" },
    e = { "<Cmd>%d<CR>", "Erase buffer" },
    l = { "<Cmd>Telescope buffers<CR>", "List buffers" },
    m = {
      "<Cmd>call Scratch() | put = execute('messages')<CR>",
      "Open message buffer",
    },
    N = {
      name = "New empty buffer",
      h = { "<Cmd>aboveleft vsplit enew<CR>", "New empty buffer left" },
      j = { "<Cmd>belowright split enew<CR>", "New empty buffer below" },
      k = { "<Cmd>aboveleft split enew<CR>", "New empty buffer above" },
      l = { "<Cmd>belowright vsplit enew<CR>", "New empty buffer right" },
      n = { "<Cmd>enew<CR>", "New empty buffer" },
    },
    n = { "<Cmd>bn<CR>", "Next buffer" },
    P = { "<Cmd>%d | put+<CR>", "Paste clipboard to whole buffer" },
    p = { "<Cmd>bp<CR>", "Previous buffer" },
    s = { "<Cmd>call Scratch()<CR>", "Scratch buffer" },
    w = { "<Cmd>setlocal readonly!<CR>", "Toggle Read-only mode" },
    Y = { "<Cmd>%y+<CR>", "Yank whole buffer to clipboard" },
  },

  c = {
    name = "Quickfix",
    c = { "<Cmd>cclose<CR>", "Close quickfix" },
    n = { "<Cmd>cnext<CR>", "Next quickfix" },
    o = { "<Cmd>copen<CR>", "Open quickfix" },
    t = { "<Cmd>BqfAutoToggle<CR>", "Toggle preview" },
    p = { "<Cmd>cprev<CR>", "Previous quickfix" },
    x = { "<Cmd>cex []<CR>", "Clear quickfix" },
  },

  e = {
    name = "Edit",
    l = {
      function()
        lint.try_lint()
      end,
      "Lint",
    },
    S = { name = "Swap with previous parameter" },
    s = { name = "Swap with next parameter" },
  },

  f = {
    name = "File",
    d = { "<Cmd>Telescope file_browser<CR>", "Pop-up file browser" },
    e = { "<Cmd>NvimTreeToggle<CR>", "Open explorer" },
    F = { "<Cmd>Telescope git_files<CR>", "Find git files" },
    f = { "<Cmd>Telescope find_files<CR>", "Find files" },
    g = { "<Cmd>Telescope live_grep<CR>", "Live grep" },
    m = { "<Cmd>Telescope marks<CR>", "Mark" },
    p = { "<Cmd>Telescope<CR>", "Pickers" },
    r = { "<Cmd>Telescope frecency<CR>", "Find recent file" },
    t = { "<Cmd>TodoTelescope<CR>", "Find TODOs" },
  },

  g = {
    name = "Git",
    ["<Space>"] = { "<Cmd>Git add %<CR>", "Stage current file" },
    a = { "<Cmd>Git add .<CR>", "Stage all files" },
    B = { "<Cmd>Git blame<CR>", "View git blame" },
    b = { "<Cmd>Telescope git_branches<CR>", "Open git branch manager" },
    d = {
      name = "Diffview",
      c = { "<Cmd>DiffviewClose<Cr>", "Diffview close" },
      d = { "<Cmd>DiffviewOpen<Cr>", "Diffview open" },
      h = { "<Cmd>DiffviewFileHistory<CR>", "Open file git history" },
    },
    f = { "<Cmd>Git fetch --all<CR>", "Fetch" },
    h = {
      name = "Hunks",
      b = {
        function()
          gitsigns.blame_line(true)
        end,
        "Blame line",
      },
      p = {
        function()
          gitsigns.preview_hunk()
        end,
        "Preview hunk",
      },
      s = {
        function()
          gitsigns.stage_hunk()
        end,
        "Stage hunk",
      },
      r = {
        function()
          gitsigns.reset_hunk()
        end,
        "Reset hunk",
      },
      u = {
        function()
          gitsigns.undo_stage_hunk()
        end,
        "Undo stage hunk",
      },
    },
    n = { "<Cmd>Neogit<CR>", "Open NeoGit" },
    r = {
      function()
        gitsigns.reset_buffer()
      end,
      "Reset buffer",
    },
    s = { "<Cmd>Git<CR>", "Open git status" },
    P = { "<Cmd>Git push<CR>", "Push" },
    p = { "<Cmd>Git pull<CR>", "Pull" },
    u = {
      function()
        gitsigns.reset_buffer_index()
      end,
      "Reset buffer index",
    },
    V = { "<Cmd>GV!<CR>", "Open log of current file" },
    v = { "<Cmd>GV<CR>", "Open log of current repo" },
  },

  h = {
    name = "Help",
    h = { "<Cmd>Telescope help_tags<CR>", "Help" },
    m = { "<Cmd>Telescope keymaps<CR>", "keymaps" },
  },

  i = {
    name = "Insert",
    d = { "<Cmd>Neogen<CR>", "Document" },
    s = { "<Cmd>Telescope symbols<CR>", "Symbols" },
  },

  K = { name = "Cheat.sh" },

  -- TODO: add test plugins.
  -- k = {
  --   name = "Test",
  --   f = { "<Cmd>w<CR>:TestFile<CR>", "Test file" },
  --   l = { "<Cmd>w<CR>:TestLast<CR>", "Test last" },
  --   n = { "<Cmd>w<CR>:TestNearest<CR>", "Test nearest" },
  --   s = { "<Cmd>w<CR>:TestSuite<CR>", "Test suite" },
  --   v = { "<Cmd>w<CR>:TestVisit<CR>", "Test visit" },
  -- },

  n = {
    name = "Notes",
    h = { "<Cmd>Twilight<CR>", "Toggle zen-mode highlight" },
    z = { "<Cmd>ZenMode<CR>", "Zen mode" },
  },

  p = {
    name = "Project",
    p = {
      function()
        telescope.extensions.project.project({ display_type = "full" })
      end,
      "List projects",
    },
    s = {
      name = "Session",
      d = { "<Cmd>DeleteSession<CR>", "Delete session" },
      l = { "<Cmd>SearchSession<CR>", "Load session" },
      r = { "<Cmd>RestoreSession<CR>", "Restore session" },
      s = { "<Cmd>SaveSession<CR>", "Save session" },
    },
  },

  s = {
    name = "Search",
    ["/"] = { "<Cmd>Telescope search_history<CR>", "Search history" },
    b = { "<Cmd>Telescope current_buffer_fuzzy_find<CR>", "Search current buffer" },
    c = { "<Cmd>Telescope command_history<CR>", "Command history" },
    f = {
      function()
        spectre.open_file_search()
      end,
      "Open file search",
    },
    s = {
      function()
        spectre.open()
      end,
      "Search file",
    },
    v = {
      function()
        spectre.open_visual({ select_word = true })
      end,
      "Visual search",
    },
    z = { "<Plug>SearchNormal", "Browser search" },
  },

  T = {
    name = "Toggle",
    c = { "<Cmd>ColorizerToggle<CR>", "Colorizer" },
    d = {
      name = "Diagnostics",
      d = { "<Cmd>lua vim.diagnostic.disable()<CR>", "Disable" },
      e = { "<Cmd>lua vim.diagnostic.enable()<CR>", "Enable" },
    },
    p = { "<Cmd>set paste!<CR>", "Paste mode" },
    s = { "<Cmd>set spell!<CR>", "Spell" },
  },

  t = {
    name = "Tabs",
    ["1"] = { "1gt", "Tab 1" },
    ["2"] = { "2gt", "Tab 2" },
    ["3"] = { "3gt", "Tab 3" },
    ["4"] = { "4gt", "Tab 4" },
    ["5"] = { "5gt", "Tab 5" },
    ["6"] = { "6gt", "Tab 6" },
    ["7"] = { "7gt", "Tab 7" },
    ["8"] = { "8gt", "Tab 8" },
    ["9"] = { "9gt", "Tab 9" },
    ["0"] = { "10gt", "Tab 10" },
    a = { "<Cmd>tabedit<CR>", "New tab" },
    c = { "<Cmd>tabclose<CR>", "Close tab" },
    n = { "<Cmd>tabnext<CR>", "Next tab" },
    p = { "<Cmd>tabprevious<CR>", "Previous tab" },
    t = {
      function()
        telescope.extensions.tele_tabby.list(utils.telescope_dropdown_theme)
      end,
      "List tabs",
    },
  },

  r = {
    name = "Run",
    c = { "<Cmd>SnipClose", "Close results" },
    K = { "<Cmd>SnipReset", "Restart SnipRun" },
    k = { "<Cmd>SnipTerminate", "Kill SnipRun" },
    s = { "<Cmd>SnipRun<CR>", "Run snippets" },
  },

  u = {
    name = "Utilities",
    c = { "<Cmd>ColorizerToggle<CR>", "Colorizer" },
    d = {
      name = "Diff tool",
      d = { "<Cmd>diffthis<CR>", "Diff this file" },
      k = { "<Cmd>diffoff<CR>", "Turn off" },
    },
    S = { "<Cmd>Sleuth<CR>", "Sleuth" },
    s = { "<Cmd>StripWhitespace<CR>", "Remove trailing whitespace" },
    u = { "<Cmd>UndotreeToggle<CR>", "Undotree" },
  },

  z = {
    name = "System",
    h = { "<Cmd>15sp +term<CR>", "New horizontal terminal" },
    M = { "<Cmd>messages clear<CR>", "Clear messages" },
    m = { "<Cmd>messages<CR>", "Messages" },
    p = {
      function()
        telescope.extensions.packer.packer()
      end,
      "Packer",
    },
    t = { "<Cmd>terminal<CR>", "New terminal" },
    U = { "<Cmd>PackerSync<CR>", "Sync plugins" },
    u = { "<Cmd>PackerUpdate<CR>", "Update plugins" },
  },
}

M.visual = {
  g = {
    name = "Git",
    h = {
      name = "Hunks",
      r = {
        function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        "Reset hunk",
      },
      s = {
        function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        "Stage hunk",
      },
    },
  },

  K = { name = "Cheat.sh" },

  r = {
    name = "Run",
    s = { "<Plug>SnipRun", "Run snippets" },
  },

  s = {
    name = "Search",
    v = {
      "<Esc>:lua require('spectre').open_visual()<CR>",
      "Visual search",
    },
    z = { "<Plug>SearchVisual", "Browser search" },
  },

  u = {
    name = "Utilities",
    s = { "<Cmd>StripWhitespace<CR>", "Remove trailing whitespace" },
  },
}

return M
