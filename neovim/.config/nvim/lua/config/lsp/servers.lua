-- TODO: seperate into multiple files
local servers = {
  clangd = {},
  pyright = {},
  rust_analyzer = {},
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

return servers
