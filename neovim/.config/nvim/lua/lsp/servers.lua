local M = {}

M.server_settings = {
  bashls = {},
  clangd = {},
  cmake = {},
  ltex = { settings = { ltex = { language = { "en-GB", "zh-CN" } } } },
  pyright = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
  sourcekit = {
    filetypes = { "swift", "objective-c", "objective-cpp" }
  },
  texlab = {
    settings = {
      latex = {
        forwardSearch = {
          executable = "zathura",
          args = { "--synctex-forward", "%l:1:%f", "%p" },
        },
      },
    },
  },
  tsserver = {},
  vimls = {},
  zk = { filetypes = { "markdown", "text" } },
}

return M
