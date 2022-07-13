local M = {}

function M.setup()
  require("lint").linters_by_ft = {
    text = { "vale" },
    lua = { "luacheck" },
    markdown = { "vale" },
    python = { "pylint" },
    rst = { "vale" },
    sh = { "shellcheck" },
    viml = { "vint" },
  }
end

return M
