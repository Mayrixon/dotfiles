# Neovim configurations

## About

This configuration is heavily inspired by
[LazyVim](https://github.com/LazyVim/LazyVim) v10.24.0.

This configuration is mainly considered for working on Linux and macOS.
Working on Windows may meet minor problems.

This configuration requires Neovim v0.9.0.
A lower version Neovim may meet problems, such as missing plugin
`Telescope.nvim`.
Besides, this configuration requires external command/program `git`, `rg`, `fd`,
and `lazygit`.
For a better/non-undefined UI, a font patched with
[Nerd Fonts](https://www.nerdfonts.com) v3 is required.

## File structure

Here is the file structure of this configuration.

```
nvim/
|-- ftplugin/
|   |-- help.lua
|   |-- ...
|-- lua/
|   |-- config/
|   |   |-- plugins.lua
|   |   |-- options.lua
|   |   |-- ...
|   |-- plugins/
|   |   |-- extras/
|   |       |-- dap.lua
|   |       |-- ...
|   |   |-- editor.lua
|   |   |-- ui.lua
|   |   |-- ...
|   |-- local/
|   |   |-- .gitignore
|   |   |-- init.lua
|   |   |-- ...
|-- init.lua
|-- README.md
```

### Plugins

Plugins are configured in folder lua/plugins.
All fundamental plugins are outside of lua/plugins/extra folder.

#### Basic configurations

Basic LSP, Treesitter, and linter/formatter configured for are listed here.

| Language   | LSP Server            | Treesitter                    | Linter/Formatter       |
| ---------- | --------------------- | ----------------------------- | ---------------------- |
| `bash`     | `bashls`              | `bash`                        | `shellharden`,`shefmt` |
| `lua`      | `lua-language-server` | `lua`, `luadoc`,`luap`        | `stylua`               |
| `markdown` | `marksman`            | `markdown`, `markdown_inline` | -                      |
| `vim`      | `vimls`               | `vim`, `vimdoc`               | -                      |

#### Extra configurations

Extra configurations are placed in folder lua/plugins/extras.

## Todo lists

- Add more keymaps for clangd

  - ClangdAST

  - ClangdSymbolInfo

  - ClangdTypeHierarchy

  - ClangdMemoryUsage

  - Clangd auto complete score

    - Example

    ```lua
    local cmp = require "cmp"
    cmp.setup {
    -- ... rest of your cmp setup ...

        sorting = {
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.recently_used,
                require("clangd_extensions.cmp_scores"),
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },

    }
    ```
