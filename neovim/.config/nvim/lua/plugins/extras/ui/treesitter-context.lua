-- Show context of the current function
return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "LazyFile",
  opts = { mode = "cursor", max_lines = 3 },
  keys = {
    {
      "<Leader>Tt",
      function()
        local tsc = require("treesitter-context")
        tsc.toggle()
        if MyVim.inject.get_upvalue(tsc.toggle, "enabled") then
          MyVim.info("Enabled Treesitter Context", { title = "Option" })
        else
          MyVim.warn("Disabled Treesitter Context", { title = "Option" })
        end
      end,
      desc = "Toggle Treesitter Context",
    },
  },
}
