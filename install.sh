#!/usr/bin/env bash

git clone https://github.com/InioX/dotfiles && cd dotfiles
git checkout nixos
sudo nixos-install --flake ".#${1}"