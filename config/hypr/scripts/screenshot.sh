#!/usr/bin/bash
timeout=4000
icon_folder="~/.config/hypr/icons"

function notification {
    notify-send "$text" -u low -a "$header" -i "${icon}" -t $timeout
}

case $1 in
  copy)
    icon="${icon_folder}/copy.png"
    header="Screenshot"
    text="Copied screen"
    grim - | wl-copy
    notification;;
  copy_area)
    icon="${icon_folder}/copy.png"
    header="Screenshot"
    text="Copied region"
    grim -g "$(slurp)" - | wl-copy
    notification;;
  save)
    icon="${icon_folder}/save.png"
    header="Screenshot"
    text="Saved screen"
    grim "$(xdg-user-dir PICTURES)/Screenshots/$(date)"
    notification;;
esac
