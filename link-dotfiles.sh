#!/usr/bin/env bash

dotfile_repo="$(pwd)"

if [[ ! -f "$dotfile_repo/$(basename $0)" ]]; then
  echo "Make sure to cd into the directory that contains this script. $dotfile_repo does not contain $(basename $0)"
  exit -1
fi

function link_file {
  local source="$1"
  local target="$2"
  local targetdir="$(dirname $target)"

  if [[ ! -e "$targetdir" ]]; then
    echo "$targetdir/ doesn't exist, creating it"
    mkdir -p "$(dirname $target)"
  elif [[ ! -d "$targetdir" ]]; then
    echo "Warning: $targetdir is not a directory, skipping"
    return 1
  elif [[ -L "$targetdir" ]]; then
    echo "Warning: $targetdir is a symbolic link, skipping"
    return 1
  fi

  if [[ ! -e "$target" ]]; then
    echo "Linking $target -> $source"
    ln -s "$source" "$target"
  elif [[ ! -L "$target" || "$(readlink $target)" != "$source" ]]; then
    echo "Warning: $target is not a link or doesn't link to $source, skipping"
  else
    echo "Correct link exists: $target, skipping"
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
