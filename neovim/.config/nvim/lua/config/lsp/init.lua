local M = {}

function M.setup()
  -- Register the lsp status progress handler
  -- require('lsp-status').register_progress()

  local servers = require('config.lsp.servers')
  for server, config in pairs(servers.server_settings) do
    servers.setup(server, config)
  end

  local utils = require('config.lsp.utils')
  require'rust-tools'.setup({
    server = {
      on_attach = utils.on_attach,
      capabilities = utils.get_general_capabilities()
    }
  })

end

return M
