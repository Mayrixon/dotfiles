local M = {}

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
  },
}

return M
