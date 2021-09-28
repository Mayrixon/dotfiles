-- TODO: complete selection from alpha2phi's config.
-- TODO: config mappings according to spacevim's.
-- TODO: clear all unmapped mappings.
local M = {}

local gitsigns = require('gitsigns')
local spectre = require('spectre')
local wk = require('which-key')

local n_opts = {
  mode = 'n',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true
}

local v_opts = {
  mode = 'v',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true
}

local leader_n_mappings = {
  -- TODO: add following bindings:
  -- - sleuth
  -- - undotree
  -- - remove trailing spaces
  -- - toggle spellcheck

  -- TODO: find a cheatsheet plugin
  -- ['?'] = {'<Cmd>Telescope keymaps<CR>', 'Show mappings'},

  w = {'<Cmd>:up<CR>', 'Update file'},
  W = {'<Cmd>:wq<CR>', 'Write file and quit'},

  ['<Space>'] = {name = 'EasyMotion'},

  -- TODO: remap this mapping, maybe move to lsp_mappings
  -- ['ac'] = {'code action'},

  b = {
    name = 'Buffer',
    -- a = {'<Cmd>%bd|e#<Cr>', 'Delete all buffers'},

    b = {'<Cmd>Telescope buffers<CR>', 'List buffers'},
    c = {'', 'Clear all saved buffers(Unmapped)'},
    d = {'<Cmd>bd<CR>', 'Delete current buffer'},
    f = {'<Cmd>bd!<CR>', 'Force delete current buffer'},
    e = {'Safe erase buffer(unmapped)'},
    m = {'Open message buffer(unmapped)'},
    n = {'<Cmd>bn<CR>', 'Next buffer'},
    P = {'Paste clipboard to whole buffer(Unmapped)'},
    p = {'<Cmd>bp<CR>', 'Previous buffer'},
    R = {'Safe revert buffer(unmapped)'},
    s = {'Scratch buffer(unmapped)'},
    t = {'Show file tree at buffer dir(unmapped)'},
    w = {'Read-only mode(unmapped)'},
    Y = {'Yank whole buffer to clipboard(Unmapped)'},

    N = {
      name = 'New empty buffer(Unmapped)',
      h = {'New empty buffer left(Unmapped)'},
      j = {'New empty buffer below(Unmapped)'},
      k = {'New empty buffer above(Unmapped)'},
      l = {'New empty buffer right(Unmapped)'},
      n = {'', 'New empty buffer(Unmapped)'}
    }
  },

  f = {
    name = 'File',
    e = {'<Cmd>NvimTreeToggle<CR>', 'Open explorer'},
    F = {'<Cmd>Telescope find_files<CR>', 'Find files'},
    f = {'<Cmd>Telescope git_files<CR>', 'Find git files'},
    g = {'<Cmd>Telescope live_grep<CR>', 'Live grep'},

    r = {'<Cmd>Telescope frecency<CR>', 'Find recent file'},
    t = {'<Cmd>TodoTelescope<CR>', 'Find TODOs'},

    -- TODO: remap or delete
    p = {'<Cmd>Telescope<CR>', 'Pickers'}
  },

  g = {
    name = 'Git',
    ['<Space>'] = {'<Cmd>Git add %<CR>', 'Stage current file'},
    a = {'<Cmd>Git add .<CR>', 'Stage all files'},
    b = {'<Cmd>Git branch<Cr>', 'Open git branch manager'},
    B = {'<Cmd>Git blame<CR>', 'View git blame'},
    f = {'<Cmd>Git fetch --all<CR>', 'Git fetch'},
    n = {'<Cmd>Neogit<CR>', 'Open NeoGit'},
    r = {function() gitsigns.reset_buffer() end, 'Reset buffer'},
    s = {'<Cmd>Git<CR>', 'Open git status'},
    p = {'<Cmd>Git push<CR>', 'Git push'},
    u = {function() gitsigns.reset_buffer_index() end, 'Reset buffer index'},
    v = {'<Cmd>GV<CR>', 'Open log of current repo'},
    V = {'<Cmd>GV!<CR>', 'Open log of current file'},

    d = {
      name = 'Diffview',
      c = {'<Cmd>DiffviewClose<Cr>', 'Diffview close'},
      d = {'<Cmd>DiffviewOpen<Cr>', 'Diffview open'},
      h = {'<Cmd>DiffviewFileHistory<CR>', 'Open file git history'}
    },

    h = {
      name = 'Hunks',
      b = {function() gitsigns.blame_line(true) end, 'Blame line'},
      p = {function() gitsigns.preview_hunk() end, 'Preview hunk'},
      s = {function() gitsigns.stage_hunk() end, 'Stage hunk'},
      r = {function() gitsigns.reset_hunk() end, 'Reset hunk'},
      u = {function() gitsigns.undo_stage_hunk() end, 'Undo stage hunk'}
    }
  },

  h = {
    name = 'Help',
    h = {'<Cmd>Telescope help_tags<CR>', 'Help'},
    m = {'<Cmd>Telescope keymaps<CR>', 'keymaps'}
  },

  n = {
    name = 'Notes',
    l = {
      name = 'Limelight',
      k = {'<Cmd>Limelight!<CR>', 'turn off'},
      l = {'<Cmd>Limelight<CR>', 'turn on'}
    },
    z = {'<Cmd>Goyo<CR>', 'Zen mode'}
  },

  q = {
    name = 'Quickfix',
    o = {'<Cmd>copen<CR>', 'Open quickfix'},
    c = {'<Cmd>cclose<CR>', 'Close quickfix'},
    n = {'<Cmd>cnext<CR>', 'Next quickfix'},
    p = {'<Cmd>cprev<CR>', 'Previous quickfix'},
    x = {'<Cmd>cex []<CR>', 'Clear quickfix'}
  },

  s = {
    name = 'Search',
    ['/'] = {'<Cmd>Telescope search_history<CR>', 'Search history'},
    c = {'<Cmd>Telescope command_history<CR>', 'Command history'},
    f = {
      function()
        spectre.open({cwd = vim.fn.getcwd(), path = vim.fn.expand('%:p:.')})
      end, 'Open file search'
    },
    s = {function() spectre.open({cwd = vim.fn.getcwd()}) end, 'Search file'},
    v = {
      function()
        spectre.open_visual({cwd = vim.fn.getcwd(), select_word = true})
      end, 'Visual search'
    }
  },

  t = {name = 'tabs', ['1'] = {'1gt', 'tab 1'}},

  -- TODO: delete after trying.
  x = {
    name = 'Trying area',
    a = {
      '<cmd>Telescope lsp_code_actions theme=get_dropdown<CR>', 'code actions'
    },
    b = {'<cmd>Telescope lsp_code_actions theme=get_cursor<CR>', 'code actions'},
    c = {'<cmd>Telescope lsp_code_actions theme=get_ivy<CR>', 'code actions'}
  },

  z = {
    name = 'System',
    l = {'<Cmd>SearchSession<CR>', 'Load session'},
    s = {'<Cmd>SaveSession<CR>', 'Save session'},
    u = {'<Cmd>PackerUpdate<CR>', 'Update plugins'}
  }

}

local leader_v_mappings = {
  g = {
    name = 'Git',
    h = {
      name = 'Hunks',
      r = {
        function()
          gitsigns.reset_hunk({vim.fn.line('.'), vim.fn.line('v')})
        end, 'Reset hunk'
      },
      s = {
        function()
          gitsigns.stage_hunk({vim.fn.line('.'), vim.fn.line('v')})
        end, 'Stage hunk'
      }
    }
  },
  s = {
    name = 'Search',
    v = {function() spectre.open_visual() end, 'Visual search'}
  }
}

-- TODO: add yank to <localleader>y
local local_n_mappings = {
  f = {
    -- TODO: change to other formatter plugins
    '<Cmd>Format<CR>', 'Format'
  },

  -- TODO: add paste in v mode
  P = {'"+P', 'Paster before here'},
  p = {'"+p', 'Paste after here'}
}

-- TODO: move LSP buffer mappings into this table.
local lsp_mappings = {}

local function get_prefix_opts(prefix, opts)
  return vim.tbl_extend('force', opts, {prefix = prefix})
end

local function set_other_operator_hints()
  -- TODO: add g, [, and ]
  wk.register({
    -- TODO: LSP-enabled only. buffer in opts would be useful
    gd = 'Definition',
    gl = 'LSP finder',

    ga = 'EasyAlign',
    gc = 'Comment',

    ['[d'] = 'Previous diagnostic',
    [']d'] = 'Next diagnostic'

  }, {prefix = ''})
end

function M.setup()
  wk.setup({
    operators = {ga = 'EasyAlign', gc = 'Comments'},
    key_labels = {
      ['<space>'] = '<Space>',
      ['<cr>'] = '<CR>',
      ['<tab>'] = '<Tab>'
    }
  })

  wk.register(leader_n_mappings, get_prefix_opts('<leader>', n_opts))
  wk.register(leader_v_mappings, get_prefix_opts('<leader>', v_opts))
  wk.register(local_n_mappings, get_prefix_opts('<localleader>', n_opts))
  set_other_operator_hints()
end

return M
