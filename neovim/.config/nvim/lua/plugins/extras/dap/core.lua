return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<Leader>d", group = "Debug" },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    -- stylua: ignore
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Continue" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<F12>", function() require("dap").step_out() end, desc = "Step Out" },
    },
  },
  ------------------------------ End modification ------------------------------
}
