# Deploy

- `Dotter` is used for zshrc only (experiment)
  - Because of lacking of folder symlink, `dotter` is only used for single-file
    configs now
- `Stow` is used for other packages
- For macOS, `neovim` is disabled now. `homebrew` would install `neovim` with
  `luv` which is not compatible with `treesitter`, which means the advantage to
  use `neovim` does not exist.

# TODOs

- [ ] Enable autocompletion in zshrc
- [ ] Add autocompletion command of `gh` into init.sh
- [ ] Add dotter's local settings template
