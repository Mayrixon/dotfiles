export LANG=en_US.UTF-8

export EDITOR=nvim
export PAGER="bat -p"

export XDG_CONFIG_HOME="$HOME/.config"

export HOMEBREW_PREFIX="$(/opt/homebrew/bin/brew --prefix)"
export CPATH=$HOMEBREW_PREFIX/include:$CPATH
export LIBRARY_PATH=$HOMEBREW_PREFIX/lib:$LIBRARY_PATH
