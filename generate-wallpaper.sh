#!/usr/bin/env bash
if [ ! -f flake.nix ]; then echo "This script is supposed to be ran from flake root." && exit 1; fi;

path="hosts/$(hostname)/wallpaper.nix"

sha256=$(curl $1 | sha256sum | cut -d ' ' -f 1 )

if [ ! -f $path ]; then
    touch $path
fi

echo $sha256

echo "{
  url = \"${1}\";
  sha256 = \"${sha256}\";
}" > $path