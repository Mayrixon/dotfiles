return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        keys = {
          {
            "<Leader>de",
            function()
              require("dapui").eval()
            end,
            desc = "Eval",
            mode = { "n", "v" },
          },
          {
            "<Leader>du",
            function()
              require("dapui").toggle({})
            end,
            desc = "Dap UI",
          },
        },
        opts = {},
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },

      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },

  -- stylua: ignore
  keys = {
    { "<F5>", function() require("dap").continue() end, desc = "Continue" },
    { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
    { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
    { "<F12>", function() require("dap").step_out() end, desc = "Step Out" },
    { "<Leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<Leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<Leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<Leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<Leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<Leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    { "<Leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<Leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<Leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<Leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<Leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<Leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<Leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<Leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<Leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<Leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

    config = function()
      local Config = require("config")
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(Config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end
    end,
  },

  -- which key integration
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<Leader>d"] = { name = "+Debug" },
        ["<Leader>da"] = { name = "+Adapters" },
      },
    },
  },

  -- mason.nvim integration
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    },
  },
}
