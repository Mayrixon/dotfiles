#!/usr/bin/env zsh

#TODO: re-organise this file into following sections:
# - prompt,
# - command completion,
# - command correction,
# - command suggestion,
# - command highlighting,
# - output coloring,
# - aliases,
# - key bindings,
# - commands history management,
# - other miscellaneous interactive tools (auto_cd, manydots-magic)...
################################################################################
# Init
################################################################################

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/z-a-rust \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-bin-gem-node

### End of Zinit's installer chunk

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

################################################################################
# Plugins
################################################################################

# Autosuggestions & fast-syntax-highlighting
# zinit ice wait lucid atinit"ZPLGM[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting

# zsh-autosuggestions
zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions

# zdharma-continuum/history-search-multi-word
zstyle ":history-search-multi-word" page-size "11"
zinit ice wait"1" lucid
zinit load zdharma-continuum/history-search-multi-word

zinit ice pick"h.sh"
zinit light paoloantinori/hhighlighter

# diff-so-fancy
zinit ice wait"2" lucid as"program" pick"bin/git-dsf"
zinit load zdharma-continuum/zsh-diff-so-fancy

zinit snippet PZTM::completion/init.zsh

# Provide A Simple Prompt Till The Theme Loads
PS1="READY >"
# zinit ice wait'!' lucid
zinit ice depth=1; zinit light romkatv/powerlevel10k

# 初始化补全
autoload -Uz compinit; compinit
# zinit 出于效率考虑会截获 compdef 调用，放到最后再统一应用，可以节省不少时间
zinit cdreplay -q


################################################################################
# Alias
################################################################################

alias ccat='pygmentize -g'

alias cd='nocorrect cd'
alias cp='nocorrect cp -i'
alias cpi='nocorrect cp -i'

alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'

alias l='ls -1A'
alias la='ll -A'
alias lc='lt -c'
alias lk='ll -Sr'
alias ll='ls -lh'
alias lm='la | "$PAGER"'
alias ln='nocorrect ln -i'
alias lni='nocorrect ln -i'
alias locate='noglob locate'
alias lr='ll -R'
alias ls='ls --group-directories-first --color=auto'
alias lt='ll -tr'
alias lu='lt -u'
alias lx='ll -XB'

alias mkdir='nocorrect mkdir -p'

alias mv='nocorrect mv -i'
alias mvi='nocorrect mv -i'

alias o=xdg-open

alias rm='nocorrect rm -i'
alias rmi='nocorrect rm -i'

alias vim='nvim'
alias vimdiff="nvim -d"

alias ssh="TERM=xterm-256color ssh"

# zoxide init. A program like z and z.lua for faster cd.
unalias zi
eval "$(zoxide init zsh)"

################################################################################
# Colorize
################################################################################

# TODO: complete colorful configurations according to archlinux's wiki.
# improved less option
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case --quit-if-one-screen --RAW-CONTROL-CHARS'
export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.

################################################################################
# Keybinds
################################################################################

bindkey -v

bindkey '^I^I' autosuggest-accept

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line                   # Opens Vim to edit current command line
bindkey '^R' history-incremental-search-backward # Perform backward search in command line history
bindkey '^S' history-incremental-search-forward  # Perform forward search in command line history
bindkey '^P' history-search-backward             # Go back/search in history (autocomplete)
bindkey '^N' history-search-forward              # Go forward/search in history (autocomplete)

bindkey -s '\ee' 'vim\n'
bindkey -s '\eo' 'cd ..\n'


################################################################################
# Options
################################################################################

##################################################
# 1. Changing Directories
##################################################

setopt auto_cd
setopt auto_pushd
setopt cdable_vars
setopt pushd_ignore_dups
setopt pushd_minus
setopt pushd_silent

##################################################
# 2. Completion
##################################################

setopt always_to_end
setopt auto_list
# setopt auto_menu
setopt complete_in_word
setopt list_types

##################################################
# 3. Expansion and Globbing
##################################################

setopt magic_equal_subst
setopt mark_dirs

##################################################
# 4. History
##################################################

setopt append_history
setopt bang_hist
setopt extended_history
setopt hist_beep
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
# Ignore history (fc -l) command in history
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
# setopt hist_verify
setopt inc_append_history
setopt share_history

##################################################
# 6. Input/Output
##################################################

setopt correct
# unsetopt flowcontrol
setopt hash_cmds
# setopt ignore_eof
setopt interactive_comments
setopt rm_star_wait

##################################################
# 7. Job Control
##################################################

setopt auto_resume
# setopt hup
setopt long_list_jobs
# setopt notify

##################################################
# 8. Prompting
##################################################

setopt prompt_subst

#############################################
# Option alias
#############################################

# BANG_HIST
# setopt hist_expand

#############################################
# # {a-c} -> a b c
# setopt brace_ccl
# # Disable menu complete for vimshell
# setopt no_menu_complete
# setopt list_rows_first
# # Expand globs when completion
# setopt glob_complete
# # Enable multi io redirection
# setopt multios
# # Can search subdirectory in $PATH
# setopt path_dirs
# # For multi byte
# setopt print_eightbit
# # Print exit value if return code is non-zero
# setopt print_exit_value
# # Short statements in for, repeat, select, if, function
# setopt short_loops
# setopt transient_rprompt
# unsetopt promptcr
# setopt numeric_glob_sort
# # Enable extended glob
# setopt extended_glob
# # Note: It is a lot of errors in script
# # setopt no_unset
# # Prompt substitution
# setopt always_last_prompt
# # List completion
# setopt auto_param_slash
# setopt auto_param_keys
# # Compact completion
# setopt list_packed
# # Check original command in alias completion
# setopt complete_aliases

################################################################################
# Others
################################################################################

# zmodload -i zsh/complist

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTORY_IGNORE='([bf]g *|[c]#cat( *)#|cd( ..)#|l[als]#( *)#|ranger|[n]#vim|z[aiqr]#( *)#)'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#INFO: remove '/' from the default value. Relating to vim-kind navigations.
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

eval $(thefuck --alias)
fuck-command-line() {
  local FUCK="$(THEFUCK_REQUIRE_CONFIRMATION=0 thefuck $(fc -ln -1 | tail -n 1) 2> /dev/null)"
  [[ -z $FUCK ]] && echo -n -e "\a" && return
  BUFFER=$FUCK
  zle end-of-line
}
zle -N fuck-command-line
bindkey "\e\e" fuck-command-line
