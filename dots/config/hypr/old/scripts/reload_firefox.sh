#!/usr/bin/env bash

position=$(hyprctl clients -j | jq 'map(select(.class=="firefox"))[].workspace.id')

if pgrep -x firefox > /dev/null
then
    pkill firefox
    hyprctl dispatch exec [workspace $position silent] firefox > /dev/null 2>&1
fi