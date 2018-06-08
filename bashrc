# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000
export HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

function build_prompt {
  # set a fancy prompt (non-color, unless we know we "want" color)
  case "$TERM" in
    xterm-color|*-256color) local color_prompt=yes;;
  esac

  if [ "$color_prompt" = yes ]; then
    PS1='\[\e[1;32m\]\u\[\e[0m\]@\h \[\e[1;34m\]\w\[\e[0m\]'
  else
    PS1='\u@\h:\w'
  fi

  if ( type "git" &> /dev/null ) && ( git branch &> /dev/null ); then
    local git_branch="$(git branch | sed -n 's/^\*.* \([^)]*\))*/\1/p')"
    PS1="$PS1 \[\e[0;35m\][\[\e[0;32m\]${git_branch}\[\e[0;35m\]]\[\e[0m\]"
  fi

  PS1="$PS1 % "

  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
    xterm*|rxvt*) PS1="\[\e]0;\u@\h: \w\a\]$PS1";;
  esac
}
PROMPT_COMMAND="build_prompt ; $PROMPT_COMMAND"

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# support colors in less
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# programs
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# tab completion settings
bind 'TAB:menu-complete'
bind 'set completion-ignore-case on'
bind 'set menu-complete-display-prefix on'
bind 'set show-all-if-ambiguous on'

# aliases
alias sl='ls'
alias ll='ls -alFh'
alias la='ls -A'
alias bx='bundle exec'
alias ..='cd ..'
