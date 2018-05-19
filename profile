# set PATH so it includes user's private bin directories
#PATH="$HOME/bin:$HOME/.local/bin:$PATH"

[ -f ~/.nvm/nvm.sh ] && source ~/.nvm/nvm.sh

if [ -d ~/.rbenv ]
then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi