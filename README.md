# My own dotfiles

## File locations

The dotfiles are seperated into folders named as applicaions' names. In this
way, it's convenient for `stow` to create soft links. However, softlinks cannot
modify configures without touching original files. In order to solve this
problem, [`dotter`](https://github.com/SuperCuber/dotter) is an optional
application.

For the users who don't installed `dotter`, it should be fine to deploy all
configures with `stow`.

## Deploy

- `Dotter` is used for zshrc only (experiment)
  - Because of lacking of folder symlink, `dotter` is only used for single-file
    configs now
- `Stow` is used for other packages
- For macOS, `neovim` is disabled now. `homebrew` would install `neovim` with
  `luv` which is not compatible with `treesitter`, which means the advantage to
  use `neovim` does not exist.

## Notes

- `tmux` requires `tpm` to install plugins, which should be completed by

  ```bash
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ```

- `hyprland` requires `wofi` as the menu provider, `dolphin` as the file manager,
  and `swaylock` to lock screens.
