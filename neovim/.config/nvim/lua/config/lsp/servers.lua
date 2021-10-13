local M = {}

M.server_settings = {
  clangd = {},
  pyright = {},
  sumneko_lua = {
    cmd = {'lua-language-server'},
    settings = {
      Lua = {
        diagnostics = {globals = {'vim'}},
        runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
          }
        },
        telemetry = {enable = false}
      }
    }
  },
  texlab = {
    settings = {
      latex = {
        forwardSearch = {
          executable = 'zathura',
          args = {'--synctex-forward', '%l:1:%f', '%p'}
        }
      }
    }
  },
  tsserver = {},
  vimls = {}
}

local utils = require('config.lsp.utils')
local general_config = {
  capabilities = utils.get_general_capabilities(),
  flags = {debounce_text_changes = 150},
  on_attach = utils.on_attach
}

local function get_server_config(config)
  local server_config = vim.tbl_deep_extend('force', general_config, config)

  return server_config
end

function M.setup(server, config)

  local lspconfig = require('lspconfig')

  local server_config = get_server_config(config)
  lspconfig[server].setup(server_config)

  local cfg = lspconfig[server]
  if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
    print(server .. ': cmd not found: ' .. vim.inspect(cfg.cmd))
  end
end

return M
