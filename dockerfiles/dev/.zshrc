umask 022
bindkey -e
setopt auto_cd
setopt auto_pushd
setopt correct
setopt nolistbeep
setopt magic_equal_subst
setopt notify
setopt equals

# ----
# Glob
# ----
setopt extended_glob
unsetopt caseglob

# -------------
# Auto complete
# -------------
autoload -U compinit
compinit
setopt auto_list
setopt auto_menu
setopt list_packed
setopt list_types
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# -------
# History
# -------
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt bang_hist
setopt extended_history
setopt hist_ignore_dups
setopt share_history
setopt hist_reduce_blanks
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
function history-all { history -E 1 }

# --------
# LS Color
# --------
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# ------
# Prompt
# ------
autoload -U colors
colors
PROMPT="(docker)%{${fg[cyan]}%}%/%%%{${reset_color}%} "
PROMPT2="%{${fg[cyan]}%}%_%%%{${reset_color}%} "
SPROMPT="%{${fg[cyan]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"

# -----
# Title
# -----
case "${TERM}" in
kterm*|xterm*|*rxvt*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}\007"
  }
  ;;
esac

# -------------------
# Peco history search
# -------------------
#setopt hist_ignore_all_dups
function peco-history-selection() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# -----
# Alias
# -----
setopt aliases
setopt complete_aliases
alias ls="ls --color"
