## About

This configuration is heavily inspired by [LazyVim](https://github.com/LazyVim/LazyVim) v6.2.0.

Mainly considered working on Linux and macOS. Working on Windows may meet minor problems.

requiring Nerd Fonts v3.
requiring Neovim v0.8.0. Some options requiring v0.9.0 or nightly.
requiring "git", "rg", { "fd", "fdfind" }, --"lazygit"

Plugins are configured in lua/plugins. All fundamental plugins are outside of lua/plugins/extra folder.

## Basic configurations

Basic LSP, Treesitter, and linter/formatter configured for
here
<!-- |-|-| - | -->
<!-- |`lua` | `lua-language-server` | `lua` | -->
<!-- | `markdown` | `marksman` |  -->
<!--  `vim` -->

```c
void main() {
    printf("Hello, world");
}
```

```rust
fn main() {
    println!{"Hello, world"};
}
```


- and
- then

*italic* **bold** ***bold and italic***  

```
LSP
bashls
lua_ls
marksman
vimls
```

```
treesitter
        "bash",
        "jsonc", -- for plugin neodev.nvim which is loaded earlier than treesitter
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
```

```
null-ls
          nls.builtins.diagnostics.zsh,
          nls.builtins.formatting.shellharden,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.stylua,
```

## Extra configurations


## File structure

```
nvim/
|-- ftplugin/
|   |-- markdown.lua
|   |-- ...
|-- lua/
|   |-- config/
|   |   |-- plugins.lua
|   |   |-- options.lua
|   |   |-- ...
|   |-- plugins/
|   |   |-- extra/
|   |       |-- dap.lua
|   |       |-- ...
|   |   |-- editor.lua
|   |   |-- ui.lua
|   |   |-- ...
|   |-- local/
|   |   |-- .gitignore
|   |   |-- init.lua
|   |   |-- icons.lua
|   |   |-- ...
|-- init.lua
|-- README.md
```

## Todo lists

### check keybinding conflicts

There are some configs in plugins/coding.lua for mini.ai may be helpful.

- kylechui/nvim-surround
- numToStr/Comment.nvim

### some other plugins configured but not installed

- inc-rename.nvim
