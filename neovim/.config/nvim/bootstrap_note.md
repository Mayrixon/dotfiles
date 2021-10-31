# Bootstrap

## Procedure

1. Use `stow`, `dotter` or any tool to create a soft link to
   `$HOME/.config/nvim`.
2. Init `nvim`, ignore all warnings.
3. Waiting for downloading plugins.
4. Quit `nvim` after file `$MYVIMRC` is opened.
5. Re-init `nvim`, and ignore all warnings again, and then quit `nvim`.
6. You can use `nvim` with plugins now.

## Trouble shooting

To restart the bootstrap, you can remove all following files:

- The Packer compiled file. It should located in folder
  `$HOME/.config/nvim/plugin`. If it's not, consult to packer configuration
  `compile_path`.
- The Packer plugin itself. It should located in
  `$HOME/.local/share/nvim/site/pack/packer/opt`. If it's not, consult to
  packer configuration `package_root`.
