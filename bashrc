# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# History settings
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
HISTIGNORE='ls:* --help'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Recursive ** and case-insensitive globbing
shopt -s globstar
shopt -s nocaseglob

# Helper functions
function try_source() {
  [[ -f "$1" ]] && source "$1"
}

function is_command() {
  command -v "$1" &> /dev/null
}

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# Prompt
GIT_PS1_SHOWCOLORHINTS=true
source ~/.vendor/git-prompt.sh

PROMPT_COMMAND='__git_ps1 "\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]\[\e[1;32m\]\u\[\e[0m\]@\h \[\e[1;34m\]\w\[\e[0m\]" " % " " \[\e[0;35m\][\[\e[0m\]%s\[\e[0;35m\]]\[\e[0m\]"'

# enable color support of ls
if is_command dircolors; then
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
if is_command nvim; then
  export EDITOR="$(command -v nvim)"
  export VISUAL="$(command -v nvim)"
elif is_command vim; then
  export EDITOR="$(command -v vim)"
  export VISUAL="$(command -v vim)"
elif is_command nano; then
  export EDITOR="$(command -v nano)"
  export VISUAL="$(command -v nano)"
fi

# programs
is_command fdfind && alias fd='fdfind'

if is_command fzf; then
  is_command fd && export FZF_ALT_C_COMMAND="fd --type d -I"
  source ~/.vendor/fzf-key-bindings.bash
fi

try_source "$HOME/.opam/opam-init/init.sh"
try_source "$HOME/.asdf/completions/asdf.bash"
try_source "$HOME/.vendor/git-completion.bash"

# aliases
alias sl='ls -F'
alias la='ls -AF'
alias l='ls -lFh'
alias ll='ls -hAlF'
alias ..='cd ..'
alias ...='cd ../..'
function cs() { cd "$@" && ls -F; }
alias magit='emacs -nw -f magit-status'

# local system config
try_source "$HOME/.bashrc_local"
