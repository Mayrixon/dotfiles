-- TODO: complete old mappings' transfer.
-- TODO: complete selection from alpha2phi's config.
-- TODO: config mappings according to spacevim's.
-- TODO: clear all unmapped mappings.
local M = {}

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
  ['?'] = {'<Cmd>Telescope keymaps<CR>', 'Show mappings'},

  -- TODO: remap this mapping, maybe move to lsp_mappings
  -- ['ac'] = {'code action'},

  b = {
    name = 'Buffer',
    -- a = {'<Cmd>%bd|e#<Cr>', 'Delete all buffers'},
    -- f = {'<Cmd>bd!<Cr>', 'Force delete current buffer'},

    b = {'', 'List buffers(Unmapped)'},
    c = {'', 'Clear all saved buffers(Unmapped)'},
    d = {'<Cmd>bd<CR>', 'Delete current buffer'},
    e = {'Safe erase buffer(unmapped)'},
    -- TODO: change formatter.
    f = {'<Cmd>Format<CR>', 'Format buffer'},
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
    b = {'<Cmd>Telescope buffers<CR>', 'Buffers'},
    e = {'<Cmd>NvimTreeToggle<CR>', 'Explorer'},
    F = {'<Cmd>Telescope find_files<CR>', 'Find files'},
    f = {'<Cmd>Telescope git_files<CR>', 'Git files'},
    g = {'<Cmd>Telescope live_grep<CR>', 'Live grep'},
    h = {'<Cmd>Telescope help_tags<CR>', 'Help'},

    r = {'<Cmd>Telescope frecency<CR>', 'Recent file'},

    -- TODO: remap or delete
    p = {'<Cmd>Telescope<CR>', 'Pickers'}
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

  -- TODO: delete after trying.
  q = {
    name = 'Trying area',

    S = {function() require('spectre').open() end, 'Search'},
    s = {'<Cmd>lua require(\'spectre\').open()<CR>', 'Search file'},

    v = {
      '<Cmd>lua require(\'spectre\').open_visual({select_word=true})<CR>',
      'Visual search'
    },
    f = {
      'viw:lua require(\'spectre\').open_file_search()<Cr>', 'Open file search'
    },
    a = {
      '<cmd>Telescope lsp_code_actions theme=get_dropdown<CR>', 'code actions'
    },
    b = {'<cmd>Telescope lsp_code_actions theme=get_cursor<CR>', 'code actions'},
    c = {'<cmd>Telescope lsp_code_actions theme=get_ivy<CR>', 'code actions'}
  },

  t = {name = 'tabs', ['1'] = {'1gt', 'tab 1'}},

  ['<Space>'] = {name = 'EasyMotion'}
}

local leader_v_mappings = {
  q = {
    name = 'Trying area',
    v = {'<Cmd>lua require(\'spectre\').open_visual()<CR>', 'Visual search'}
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
  local wk = require('which-key')

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
  local wk = require('which-key')
  wk.setup({
    operators = {ga = 'EasyAlign', gc = 'Comments'},
    key_labels = {['<Space>'] = 'SPC', ['<CR>'] = 'RET', ['<Tab>'] = 'TAB'}
  })

  wk.register(leader_n_mappings, get_prefix_opts('<leader>', n_opts))
  wk.register(leader_v_mappings, get_prefix_opts('<leader>', v_opts))
  wk.register(local_n_mappings, get_prefix_opts('<localleader>', n_opts))
  set_other_operator_hints()
end

return M
