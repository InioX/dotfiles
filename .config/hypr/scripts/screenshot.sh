#!/usr/bin/bash
case $1 in
  copy)
    grim - | wl-copy;;
  copy_region)
    grim -g "$(slurp)" - | wl-copy;;
  save)
    grim "$(xdg-user-dir PICTURES)/Screenshots/$(date)"
esac
