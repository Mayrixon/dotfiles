local wk = require("which-key")

local mappings = {
  l = {
    name = "Rust analyzer",
    c = { "<Cmd>RustOpenCargo<CR>", "Open cargo.toml" },
    g = { "<Cmd>RustViewCrateGraph<CR>", "View crate graph" },
    m = { "<Cmd>RustExpandMacro<CR>", "Expand macro" },
    p = { "<Cmd>RustParentModule<CR>", "Parent module" },
    r = { "<Cmd>RustReloadWorkspace<CR>", "Reload workspace" },
    s = {
      "<Cmd>RustStartStandaloneServerForBuffer<CR>",
      "Start standalone server",
    },

    l = {
      name = "List",
      d = { "<Cmd>RustDebuggables<CR>", "Debuggables" },
      r = { "<Cmd>RustRunnables<CR>", "Runnables" },
    },
  },
}

wk.register(mappings, { prefix = "<localleader>", mode = "n" })
