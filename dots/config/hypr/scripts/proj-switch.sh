#!/usr/bin/env bash

DEV_DIR="$HOME/dev"

project=$(find "$DEV_DIR" -mindepth 1 -maxdepth 1 -type d \
  | sed "s|$DEV_DIR/||" \
  | rofi -dmenu -theme ~/.config/rofi/menu.rasi -i -p "Dev project:")

[ -z "$project" ] && exit 0

cd "$DEV_DIR/$project" || exit 1

# alacritty --working-directory "$DEV_DIR/$project" &

code "$DEV_DIR/$project" &

notify-send "  Opened the $DEV_DIR/$project project"