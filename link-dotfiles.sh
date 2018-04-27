#!/bin/bash

dotfile_repo="$(pwd)"
shopt -s nullglob

if [ ! -f "$dotfile_repo/$(basename $0)" ]; then
  echo "$dotfile_repo does not contain $(basename $0)"
  exit -1
fi

function link_file {
  source="$1"
  target="$2"
  targetdir="$(dirname $target)"

  if [[ ! -d "$targetdir" ]]; then
    echo "$targetdir/ doesn't exist, creating it"
    mkdir -p "$(dirname $target)"
  fi

  if [[ -f "$target" || -d "$target" ]]; then
    echo "$target exists, skipping"
  else
    echo "linking $target -> $source"
    ln -sT "$source" "$target"
  fi
}

for file in $(find $dotfile_repo -type f ! -path '*/.git/*' ! -name 'link-dotfiles.sh' ! -name '.*' -printf '%P\n')
do
  dirname="$(dirname $file)"
  filename="$(basename $file)"

  if [ $dirname == "." ]; then
    link_file "$dotfile_repo/$file" "$HOME/.$filename"
  else
    link_file "$dotfile_repo/$file" "$HOME/.$dirname/$filename"
  fi
done
