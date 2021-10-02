# Nvim Lua config

## Refectory

- [ ] Clear the plugin list.
- [ ] Clear all backup files.
- [ ] Clear all TODOs.
- [-] Setup which-key mappings without all mapped.
  - [ ] Based on alpha2phi's.
  - [-] Based on Spacevim's.
    - [x] Map `<leader>-b`.
    - [x] Map `<leader>-s`.
    - [x] Map `<leader>-g`.
- [ ] Finish which-key mapping bindings.
- [x] Cleanup the following TODO list.
  - [x] Delete outdated items.
  - [x] Delete un-necessary items.
  - [x] Update to the current plans.

## TODOs

- [ ] Consider the process between telescope -> quickfix and telescope -> trouble.
- [-] Status line
  - [-] Setup lualine.
    - [x] Basic settings according to lightline.
    - [-] Add lsp\_status.
      - [ ] Config lsp\_status.
- [ ] LSP
  - [ ] Set up servers
  - [ ] Set up autocomplete
  - [ ] Set up code actions
    - [ ] Setup according to VS Code and LSP functions' definations.
      - [ ] Definition
      - [ ] Declaration
      - [ ] Implementation
      - [ ] References
      - [ ] Hover
      - [ ] Type defination
    - [ ] Compare lspsaga with (telescope + native LSP + goto-preview)
  - [ ] Adujust appearance
    - [ ] Adjust notice color
- [ ] Set up formatters
- [-] Add old plugins and configs
  - [-] Plugins
    - [-] undotree
    - [ ] better-whitespace
    - [ ] gutentags
    - [ ] Goyo and limelight (disable gitsigns)
  - [-] Compare plugins
    - [ ] Colorizer and nvim-colorizer.lua
    - [ ] Neogit vs fugitive
    - [ ] lspsaga vs telescope LSP functions
- [-] Tree sitter
- [ ] Spell checker
- [-] Zen mode
  - [x] Setup Goyo and limelight
  - [x] Find a way to store value of scrolloff temporarilly
  - [ ] TrueZen
- [-] Markdown
  - [-] Highlight (waiting for tree-sitter)
  - [-] Edit
    - [ ] mkdx newline settings
- [ ] DAP
- [ ] Optimise startup time
  - [ ] Profile:
    - [ ] packer's profile
    - [ ] vim-startuptime
  - [ ] Use plugin impatient
- [ ] Setup startup screen
