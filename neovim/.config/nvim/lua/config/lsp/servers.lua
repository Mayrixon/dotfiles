local server_settings = {
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

local M = {}
local lsp_status = require('lsp-status')

function M.get_general_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- lsp_status settings
  capabilities = vim.tbl_extend('keep', capabilities or {},
                                lsp_status.capabilities)

  -- for nvim-cmp
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  return capabilities
end

M.on_attach = function(client, bufnr)
  local utils = require('config.lsp.utils')
  local cosmetics = require('config.lsp.cosmetics')

  -- require'lsp_signature'.setup({
  --   bind = true,
  --   handler_opts = {border = border_kind}
  -- })

  lsp_status.on_attach(client)

  utils.set_buffer_option(bufnr)

  utils.set_keymap_1(bufnr)
  utils.set_keymap_2(client, bufnr)

  utils.set_hover_diagnostics()

  cosmetics.set_document_highlight(client)
end

function M.set_servers()
  local general_config = {
    capabilities = M.get_general_capabilities(),
    flags = {debounce_text_changes = 150},
    on_attach = M.on_attach
  }

  local nvim_lsp = require('lspconfig')

  for server, config in pairs(server_settings) do
    local server_config = vim.tbl_deep_extend('force', general_config, config)
    nvim_lsp[server].setup(server_config)

    local cfg = nvim_lsp[server]
    if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
      print(server .. ': cmd not found: ' .. vim.inspect(cfg.cmd))
    end
  end
end

return M
