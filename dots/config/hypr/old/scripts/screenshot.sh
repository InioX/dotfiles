#!/usr/bin/env bash
case $1 in
  copy)
    hyprshot -m output --clipboard-only;;
  copy_area)
    hyprshot -m region --clipboard-only --freeze;;
  save)
    hyprshot -m output;;
esac
