local M = {}

function M.setup()
  require('lsp-status').register_progress()

  local cosmetics = {}
  cosmetics.border_type = 'rounded'
  require('config.lsp.cosmetics').setup(cosmetics)

  local servers = require('config.lsp.servers')
  servers.set_servers()

  require'rust-tools'.setup({
    server = {
      on_attach = servers.on_attach,
      capabilities = servers.get_general_capabilities()
    },
    tools = {hover_actions = {border = cosmetics.border_type}}
  })
end

return M
