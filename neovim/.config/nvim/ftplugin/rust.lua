local wk = require("which-key")

wk.add({
  { "<LocalLeader>l", group = "Rust Analyzer" },
  { "<LocalLeader>lc", "<Cmd>RustLsp openCargo<CR>", desc = "Open cargo.toml" },
  { "<LocalLeader>lg", "<Cmd>RustLsp crateGraph<CR>", desc = "View crate graph" },
  { "<LocalLeader>ll", group = "List" },
  { "<LocalLeader>lld", "<Cmd>RustLsp debuggables<CR>", desc = "Debuggables" },
  { "<LocalLeader>llr", "<Cmd>RustLsp runnables<CR>", desc = "Runnables" },
  { "<LocalLeader>llt", "<Cmd>RustLsp testables<CR>", desc = "Tesables" },
  { "<LocalLeader>lm", "<Cmd>RustLsp expandMacro<CR>", desc = "Expand macro" },
  { "<LocalLeader>lp", "<Cmd>RustLsp parentModule<CR>", desc = "Parent module" },
  { "<LocalLeader>lr", "<Cmd>RustLsp rebuildProcMacros<CR>", desc = "Rebuild proc macros" },
  { "<LocalLeader>ls", "<Cmd>RustStartStandaloneServerForBuffer<CR>", desc = "Start standalone server" },
  { "<LocalLeader>lv", group = "View" },
  { "<LocalLeader>lvH", "<Cmd>Rustc view hir<CR>", desc = "View Rustc HIR" },
  { "<LocalLeader>lvM", "<Cmd>Rustc view mir<CR>", desc = "View Rustc MIR" },
  { "<LocalLeader>lvh", "<Cmd>RustLsp view hir<CR>", desc = "View RustLsp HIR" },
  { "<LocalLeader>lvm", "<Cmd>RustLsp view mir<CR>", desc = "View RustLsp MIR" },
})
