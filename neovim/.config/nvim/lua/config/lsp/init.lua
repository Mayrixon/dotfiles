-- TODO: seperate server files into languate-specific files. With this update,
-- it's easier to setup language specific keymappings.
local M = {}

local lsp_utils = require('config.lsp.utils')

function M.setup()
  -- Register the lsp status progress handler
  require('lsp-status').register_progress()

  -- LSPs
  -- local servers = { "pyright", "rust_analyzer", "tsserver", "vimls"}
  -- for _, lsp in ipairs(servers) do
  --     nvim_lsp[lsp].setup {
  --         capabilities = capabilities;
  --         on_attach = on_attach;
  --         -- init_options = {
  --         --     onlyAnalyzeProjectsWithOpenFiles = true,
  --         --     suggestFromUnimportedLibraries = false,
  --         --     closingLabels = true,
  --         -- };
  --     }
  -- end
  local servers = require('config.lsp.servers')
  for server, config in pairs(servers) do
    lsp_utils.setup_server(server, config)
  end
end

return M
