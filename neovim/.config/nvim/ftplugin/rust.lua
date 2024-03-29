local wk = require("which-key")

local mappings = {
  l = {
    name = "+Rust Analyzer",
    c = { "<Cmd>RustLsp openCargo<CR>", "Open cargo.toml" },
    g = { "<Cmd>RustLsp crateGraph<CR>", "View crate graph" },
    m = { "<Cmd>RustLsp expandMacro<CR>", "Expand macro" },
    p = { "<Cmd>RustLsp parentModule<CR>", "Parent module" },
    r = { "<Cmd>RustLsp rebuildProcMacros<CR>", "Rebuild proc macros" },
    s = {
      "<Cmd>RustStartStandaloneServerForBuffer<CR>",
      "Start standalone server",
    },

    v = {
      name = "+View",
      h = { "<Cmd>RustLsp view hir<CR>", "View RustLsp HIR" },
      m = { "<Cmd>RustLsp view mir<CR>", "View RustLsp MIR" },
      H = { "<Cmd>Rustc view hir<CR>", "View Rustc HIR" },
      M = { "<Cmd>Rustc view mir<CR>", "View Rustc MIR" },
    },

    l = {
      name = "+List",
      d = { "<Cmd>RustLsp debuggables<CR>", "Debuggables" },
      r = { "<Cmd>RustLsp runnables<CR>", "Runnables" },
      t = { "<Cmd>RustLsp testables<CR>", "Tesables" },
    },
  },
}

wk.register(mappings, { prefix = "<LocalLeader>", mode = "n" })
