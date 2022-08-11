-- TODO: add formatter for:
-- - norg
-- - org
-- INFO: there is a formatter taplo could be used for toml.
local filetypes = require("formatter.filetypes")

local M = {}

function M.setup()
  require("formatter").setup({
    logging = true,
    filetype = {
      c = { filetypes.c.clangformat },
      cmake = { filetypes.cmake.cmakeformat },
      cpp = { filetypes.cpp.clangformat },
      html = { filetypes.html.prettier },
      javascript = { filetypes.javascript.prettier },
      json = { filetypes.json.prettier },
      lua = { filetypes.lua.stylua },
      markdown = { filetypes.markdown.prettier },
      python = {
        filetypes.python.isort,
        filetypes.python.yapf,
      },
      rust = { filetypes.rust.rustfmt },
      sh = { filetypes.sh.shfmt },
      tex = {
        -- latexindent
        function()
          return {
            exe = "latexindent",
            args = { "-sl", "-g /dev/stderr", "2>/dev/null" },
            stdin = true,
          }
        end,
      },
      typescript = { filetypes.typescript.prettier },
    },
  })
end

return M
