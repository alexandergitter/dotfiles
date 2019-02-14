#!/usr/bin/env bash

dotfile_repo="$(pwd)"

if [[ ! -f "$dotfile_repo/$(basename $0)" ]]; then
  echo "$dotfile_repo does not contain $(basename $0)"
  exit -1
fi

function link_file {
  local source="$1"
  local target="$2"
  local targetdir="$(dirname $target)"

  if [[ ! -d "$targetdir" ]]; then
    echo "$targetdir/ doesn't exist, creating it"
    mkdir -p "$(dirname $target)"
  fi

  if [[ -f "$target" || -d "$target" ]]; then
    echo "$target exists, skipping"
  else
    echo "linking $target -> $source"
    ln -s "$source" "$target"
  fi
}

for file in $(find $dotfile_repo -type f ! -path '*/.git/*' ! -name 'link-dotfiles.sh' ! -name '.*' -print)
do
  relative_file=${file#"$dotfile_repo/"}
  dirname="$(dirname $relative_file)"
  filename="$(basename $relative_file)"

  if [[ $dirname == "." ]]; then
    link_file "$dotfile_repo/$relative_file" "$HOME/.$filename"
  else
    link_file "$dotfile_repo/$relative_file" "$HOME/.$dirname/$filename"
  fi
done
