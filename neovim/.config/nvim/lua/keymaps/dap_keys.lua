-- TODO: config mappings.
local M = {}
local dap_nvim_dap_mappings = {
  d = {
    name = "DAP",
    b = { "<Cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle breakpoint" },
    c = { "<Cmd>lua require('dap').continue()<CR>", "Continue" },
    s = { "<Cmd>lua require('dap').step_over()<CR>", "Step over" },
    i = { "<Cmd>lua require('dap').step_into()<CR>", "Step into" },
    o = { "<Cmd>lua require('dap').step_out()<CR>", "Step out" },
    u = { "<Cmd>lua require('dapui').toggle()<CR>", "Toggle UI" },
    p = { "<Cmd>lua require('dap').repl.open()<CR>", "REPL" },
    e = { '<Cmd>lua require"telescope".extensions.dap.commands{}<CR>', "Commands" },
    f = { '<Cmd>lua require"telescope".extensions.dap.configurations{}<CR>', "Configurations" },
    r = { '<Cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>', "List breakpoints" },
    v = { '<Cmd>lua require"telescope".extensions.dap.variables{}<CR>', "Variables" },
    m = { '<Cmd>lua require"telescope".extensions.dap.frames{}<CR>', "Frames" },

    -- Refactoring print
    P = { ':lua require("refactoring").debug.printf({below = false})<CR>', "Print" },
    C = { ':lua require("refactoring").debug.cleanup({})<CR>', "Clear print" },
  },
}

local dap_vimspector_mappings = {
  d = {
    name = "DAP",
    b = { "<Cmd>call vimspector#ToggleBreakpoint()<CR>", "Toggle breakpoint" },
    c = { "<Cmd>call vimspector#Continue()<CR>", "Continue" },
    s = { "<Cmd>call vimspector#StepOver()<CR>", "Step over" },
    i = { "<Cmd>call vimspector#StepInto()<CR>", "Step into" },
    o = { "<Cmd>call vimspector#StepOut()<CR>", "Step out" },
    u = { "<Cmd>call vimspector#Launch()<CR>", "Launch" },
    f = { "<Cmd>call vimspector#GetConfigurations()<CR>", "Configurations" },
    r = { "<Cmd>call vimspector#ListBreakPoints()<CR>", "List breakpoints" },
    v = { "<Cmd>call vimspector#AddWatch()<CR>", "Add watch" },
    m = { "<Cmd>call vimspector#Evaluate()<CR>", "Evaluate" },

    -- Refactoring print
    P = { ':lua require("refactoring").debug.printf({below = false})<CR>', "Print" },
    C = { ':lua require("refactoring").debug.cleanup({})<CR>', "Clear print" },
  },

  --- REFACTORING WIP
  --
  -- Vimspector
  -- ["<F5>"] = {name = "Vimspector - Launch"},
  -- ["<F8>"] = {name = "Vimspector - Run to Cursor"},
  -- ["<F9>"] = {name = "Vimspector - Cond. Breakpoint"},

  --     utils.map_key('n', '<leader>dsc',
  --                   '<cmd>lua require"dap.ui.variables".scopes()<CR>')
  --     utils.map_key('n', '<leader>dhh',
  --                   '<cmd>lua require"dap.ui.variables".hover()<CR>')
  --     utils.map_key('v', '<leader>dhv',
  --                   '<cmd>lua require"dap.ui.variables".visual_hover()<CR>')

  --     utils.map_key('n', '<leader>duh',
  --                   '<cmd>lua require"dap.ui.widgets".hover()<CR>')
  --     utils.map_key('n', '<leader>duf',
  --                   "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")

  --     utils.map_key('n', '<leader>dsbr',
  --                   '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
  --     utils.map_key('n', '<leader>dsbm',
  --                   '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
  --     utils.map_key('n', '<leader>drl',
  --                   '<cmd>lua require"dap".repl.run_last()<CR>')
}
function M.register_dap_vimspector()
  local wk = require("which-key")
  wk.register({
    ["dx"] = {
      ":lua require('config.whichkey').register_dap_nvim_dap()<CR>",
      "Switch to nvim-dap",
    },
  }, opts)
  wk.register(dap_vimspector_mappings, opts)
  vim.g.my_debugger = "v"
  vim.g.vimspector_enable_mappings = "HUMAN"
end

function M.register_dap_nvim_dap()
  local wk = require("which-key")
  wk.register({
    ["dx"] = { ":lua require('config.whichkey').register_dap_vimspector()<CR>", "Switch to vimspector" },
  }, opts)
  wk.register(dap_nvim_dap_mappings, opts)
  vim.g.my_debugger = "d"
  vim.g.vimspector_enable_mappings = ""
end

function M.register_dap()
  if vim.g.my_debugger == "v" then
    M.register_dap_vimspector()
  else
    M.register_dap_nvim_dap()
  end
end

M.normal_mappings = {

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
}
