# set PATH so it includes user's private bin directories
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
export SRC_DIR="$HOME/src"

[ -x "$(command -v opam)" ] && eval $(opam env)
[ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh
