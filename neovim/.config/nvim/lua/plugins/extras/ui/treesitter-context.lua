return {
  --------------------- Modified LazyVim's plugin settings ---------------------
  {
    "nvim-treesitter-context",
    opts = function()
      local tsc = require("treesitter-context")
      Snacks.toggle({
        name = "Treesitter Context",
        get = tsc.enabled,
        set = function(state)
          if state then
            tsc.enable()
          else
            tsc.disable()
          end
        end,
      }):map("<Leader>Tt")
      return { mode = "cursor", max_lines = 3 }
    end,
  },
  ------------------------------ End modification ------------------------------
}
