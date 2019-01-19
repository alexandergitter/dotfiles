# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# History settings
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTIGNORE='ls:* --help'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Prompt
GIT_PS1_SHOWCOLORHINTS=true
source ~/.vendor/git-prompt.sh

PROMPT_COMMAND='__git_ps1 "\[\e[1;32m\]\u\[\e[0m\]@\h \[\e[1;34m\]\w\[\e[0m\]" " % " " \[\e[0;35m\][\[\e[0m\]%s\[\e[0;35m\]]\[\e[0m\]"'

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

# default editor
if command -v nvim &> /dev/null; then
  export EDITOR="$(command -v nvim)"
  export VISUAL="$(command -v nvim)"
elif command -v vim &> /dev/null; then
  export EDITOR="$(command -v vim)"
  export VISUAL="$(command -v vim)"
elif command -v nano &> /dev/null; then
  export EDITOR="$(command -v nano)"
  export VISUAL="$(command -v nano)"
fi

# programs
if [ -f ~/.fzf.bash ]; then
  ( command fd &> /dev/null ) && export FZF_ALT_C_COMMAND="fd --type d -I"
  source ~/.fzf.bash
fi

[ -f ~/.asdf/completions/asdf.bash ] && source ~/.asdf/completions/asdf.bash
source ~/.vendor/z.sh


# tab completion settings
bind 'TAB:menu-complete'
bind 'set completion-ignore-case on'
bind 'set menu-complete-display-prefix on'
bind 'set show-all-if-ambiguous on'

# aliases
alias sl='ls'
alias la='ls -AF'
alias l='ls -lFGh'
alias ll='ls -hAlF'
alias bx='bundle exec'
alias ..='cd ..'
alias ...='cd ../..'
function cs() { cd "$@" && ls; }
function cheat() { curl cht.sh/$1; }

# local system config
[ -f ~/.bashrc_local ] && source ~/.bashrc_local
