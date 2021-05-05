local servers = {
    pyright = {},
    rust_analyzer = {},
    tsserver = {},
    vimls = {},
    sumneko_lua = {
        cmd = {'lua-language-server'},
        settings = {
            Lua = {
                diagnostics = {globals = {'vim'}},
                runtime = {
                    version = 'LuaJIT',
                    path = vim.split(package.path, ';')
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                    }
                },
                telemetry = {enable = false}
            }
        }
    }
}

return servers
