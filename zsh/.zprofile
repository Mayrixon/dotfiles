export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

eval "$(/opt/homebrew/bin/brew shellenv)"
. "$HOME/.cargo/env"
export PATH=$PATH:$HOME/.local/bin:$HOME/.local/share/nvim/mason/bin
