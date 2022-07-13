-- TODO: clear all unmapped mappings.
local gitsigns = require("gitsigns")
local spectre = require("spectre")

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

M.normal_mappings = {
  ["<Space>"] = { name = "EasyMotion" },

  ["?"] = { "<Cmd>Cheatsheet<CR>", "Cheat sheet" },

  b = {
    name = "Buffer",
    -- a = {'<Cmd>%bd|e#<Cr>', 'Delete all buffers'},

    b = { "<Cmd>Telescope buffers<CR>", "List buffers" },
    c = { "<Cmd>call DeleteHiddenBuffers()<CR>", "Clear all saved buffers" },
    d = { "<Cmd>bd<CR>", "Delete current buffer" },
    f = { "<Cmd>bd!<CR>", "Force delete current buffer" },
    e = { "<Cmd>%d<CR>", "Erase buffer" },
    m = {
      "<Cmd>call Scratch() | put = execute('messages')<CR>",
      "Open message buffer",
    },
    n = { "<Cmd>bn<CR>", "Next buffer" },
    P = { "<Cmd>%d | put+<CR>", "Paste clipboard to whole buffer" },
    p = { "<Cmd>bp<CR>", "Previous buffer" },
    R = { "Safe revert buffer(unmapped)" },
    s = { "<Cmd>call Scratch()<CR>", "Scratch buffer" },
    t = { "Show file tree at buffer dir(unmapped)" },
    w = { "<Cmd>setlocal readonly!<CR>", "Toggle Read-only mode" },
    Y = { "<Cmd>%y+<CR>", "Yank whole buffer to clipboard" },

    N = {
      name = "New empty buffer",
      h = { "<Cmd>aboveleft vsplit enew<CR>", "New empty buffer left" },
      j = { "<Cmd>belowright split enew<CR>", "New empty buffer below" },
      k = { "<Cmd>aboveleft split enew<CR>", "New empty buffer above" },
      l = { "<Cmd>belowright vsplit enew<CR>", "New empty buffer right" },
      n = { "<Cmd>enew<CR>", "New empty buffer" },
    },
  },

  d = {
    name = "DAP",
    b = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "Toggle breakpoint",
    },
    c = {
      function()
        require("dap").continue()
      end,
      "Continue",
    },
    d = {
      function()
        require("dapui").toggle()
      end,
      "Toggle UI",
    },
    e = {
      function()
        require("telescope").extensions.dap.commands({})
      end,
      "Commands",
    },
    f = {
      function()
        require("telescope").extensions.dap.configurations({})
      end,
      "Configurations",
    },
    i = {
      function()
        require("dap").step_into()
      end,
      "Step into",
    },
    m = {
      function()
        require("telescope").extensions.dap.frames({})
      end,
      "Frames",
    },
    o = {
      function()
        require("dap").step_out()
      end,
      "Step out",
    },
    p = {
      function()
        require("dap").repl.open()
      end,
      "REPL",
    },
    s = {
      function()
        require("dap").step_over()
      end,
      "Step over",
    },

    l = {
      name = "Lists",
      r = {
        function()
          require("telescope").extensions.dap.list_breakpoints({})
        end,
        "List breakpoints",
      },
      v = {
        function()
          require("telescope").extensions.dap.variables({})
        end,
        "Variables",
      },
    },
  },

  e = {
    name = "Edit",
    l = {
      function()
        require("lint").try_lint()
      end,
      "Lint",
    },
    s = { name = "Swap with next parameter" },
    S = { name = "Swap with previous parameter" },
  },

  f = {
    name = "File",
    d = { "<Cmd>Telescope file_browser<CR>", "Pop-up file browser" },
    e = { "<Cmd>NvimTreeToggle<CR>", "Open explorer" },
    F = { "<Cmd>Telescope find_files<CR>", "Find files" },
    f = {
      function()
        require("config.telescope").find_project_files()
      end,
      "Find project files",
    },
    g = { "<Cmd>Telescope live_grep<CR>", "Live grep" },
    p = { "<Cmd>Telescope<CR>", "Pickers" },
    r = { "<Cmd>Telescope frecency<CR>", "Find recent file" },
    t = { "<Cmd>TodoTelescope<CR>", "Find TODOs" },
  },

  g = {
    name = "Git",
    ["<Space>"] = { "<Cmd>Git add %<CR>", "Stage current file" },
    a = { "<Cmd>Git add .<CR>", "Stage all files" },
    b = { "<Cmd>Telescope git_branches<CR>", "Open git branch manager" },
    B = { "<Cmd>Git blame<CR>", "View git blame" },
    f = { "<Cmd>Git fetch --all<CR>", "Git fetch" },
    n = { "<Cmd>Neogit<CR>", "Open NeoGit" },
    r = {
      function()
        gitsigns.reset_buffer()
      end,
      "Reset buffer",
    },
    s = { "<Cmd>Git<CR>", "Open git status" },
    p = { "<Cmd>Git push<CR>", "Git push" },
    u = {
      function()
        gitsigns.reset_buffer_index()
      end,
      "Reset buffer index",
    },
    v = { "<Cmd>GV<CR>", "Open log of current repo" },
    V = { "<Cmd>GV!<CR>", "Open log of current file" },

    d = {
      name = "Diffview",
      c = { "<Cmd>DiffviewClose<Cr>", "Diffview close" },
      d = { "<Cmd>DiffviewOpen<Cr>", "Diffview open" },
      h = { "<Cmd>DiffviewFileHistory<CR>", "Open file git history" },
    },

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
  },

  h = {
    name = "Help",
    h = { "<Cmd>Telescope help_tags<CR>", "Help" },
    m = { "<Cmd>Telescope keymaps<CR>", "keymaps" },
  },

  i = { name = "Insert", s = { "<Cmd>Telescope symbols<CR>", "Symbols" } },

  k = {
    name = "Test",
    f = { "<Cmd>w<CR>:TestFile<CR>", "Test file" },
    l = { "<Cmd>w<CR>:TestLast<CR>", "Test last" },
    n = { "<Cmd>w<CR>:TestNearest<CR>", "Test nearest" },
    s = { "<Cmd>w<CR>:TestSuite<CR>", "Test suite" },
    v = { "<Cmd>w<CR>:TestVisit<CR>", "Test visit" },
  },

  n = {
    name = "Notes",
    c = {
      name = "Highlight",
      c = { "<Cmd>TwilightEnable<CR>", "Turn on" },
      d = { "<Cmd>TwilightDisable<CR>", "Turn off" },
    },
    z = { "<Cmd>TZAtaraxis<CR>", "Zen mode" },
  },

  p = {
    -- TODO: add plugins to config dictionary-base settings
    name = "Project",
    p = {
      function()
        require("telescope").extensions.project.project({ display_type = "full" })
      end,
      "List projects",
    },
  },

  q = {
    name = "Quickfix",
    o = { "<Cmd>copen<CR>", "Open quickfix" },
    c = { "<Cmd>cclose<CR>", "Close quickfix" },
    n = { "<Cmd>cnext<CR>", "Next quickfix" },
    p = { "<Cmd>cprev<CR>", "Previous quickfix" },
    x = { "<Cmd>cex []<CR>", "Clear quickfix" },
  },

  s = {
    name = "Search",
    ["/"] = { "<Cmd>Telescope search_history<CR>", "Search history" },
    b = { "<Plug>SearchNormal", "Browser search" },
    c = { "<Cmd>Telescope command_history<CR>", "Command history" },
    f = {
      function()
        spectre.open({ cwd = vim.fn.getcwd(), path = vim.fn.expand("%:p:.") })
      end,
      "Open file search",
    },
    s = {
      function()
        spectre.open({ cwd = vim.fn.getcwd() })
      end,
      "Search file",
    },
    v = {
      function()
        spectre.open_visual({ cwd = vim.fn.getcwd(), select_word = true })
      end,
      "Visual search",
    },
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
    c = { "<Cmd>tabclose<CR>", "Close tab" },
    e = { "<Cmd>tabedit<CR>", "New tab" },
    n = { "<Cmd>tabnext<CR>", "Next tab" },
    p = { "<Cmd>tabprevious<CR>", "Previous tab" },
    t = {
      function()
        require("telescope").extensions.tele_tabby.list(require("config.telescope").dropdown_theme)
      end,
      "List tabs",
    },
  },

  T = {
    name = "Toggle",
    p = { "<Cmd>set paste!<CR>", "Paste mode" },
    s = { "<Cmd>set spell!<CR>", "Spell" },
  },

  u = {
    name = "Utilities",
    c = { "<Cmd>ColorizerToggle<CR>", "Colorizer" },
    s = { "<Cmd>StripWhitespace<CR>", "Remove trailing whitespace" },
    S = { "<Cmd>Sleuth<CR>", "Sleuth" },
    u = { "<Cmd>UndotreeToggle<CR>", "Undotree" },
    w = { "<Cmd>MatchupWhereAmI??<CR>", "Where am I" },

    d = {
      name = "Diff tool",
      d = { "<Cmd>diffthis<CR>", "Diff this file" },
      o = { "<Cmd>diffoff<CR>", "Turn off" },
    },
  },

  z = {
    name = "System",
    h = { "<Cmd>15sp +term<CR>", "New horizontal terminal" },
    l = { "<Cmd>SearchSession<CR>", "Load session" },
    p = {
      function()
        require("telescope").extensions.packer.packer()
      end,
      "Packer",
    },
    s = { "<Cmd>SaveSession<CR>", "Save session" },
    t = { "<Cmd>terminal<CR>", "New terminal" },
    u = { "<Cmd>PackerUpdate<CR>", "Update plugins" },
    U = { "<Cmd>PackerSync<CR>", "Sync plugins" },
  },
}

M.visual_mappings = {
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
  s = {
    name = "Search",
    b = { "<Plug>SearchVisual", "Browser search" },
    v = {
      function()
        spectre.open_visual()
      end,
      "Visual search",
    },
  },
  u = {
    name = "Utilities",
    s = { "<Cmd>StripWhitespace<CR>", "Remove trailing whitespace" },
  },
}

return M
