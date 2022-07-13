local settings = { cosmetics = { border_types = "rounded" } }

local M = {}

function M.setup()
  require("lsp-status").register_progress()

  require("config.lsp.cosmetics").setup(settings)

  local servers = require("config.lsp.servers")
  servers.set_servers()

  require("rust-tools").setup({
    server = {
      on_attach = servers.on_attach,
      capabilities = servers.get_general_capabilities(),
    },
    tools = {
      hover_actions = {
        border = settings.cosmetics.border_type,
        auto_focus = true,
      },
    },
  })
end

return M
