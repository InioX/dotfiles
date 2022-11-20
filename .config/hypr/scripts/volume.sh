#!/bin/bash
#Usage: ./volume.sh [output-up / output-down / output-mute] [int]
#Usage: ./volume.sh [input-up / input-down / input-mute] [int]

dir=`dirname "$0"`
icon_folder="~/.config/hypr/icons"
amount=$2
id_output="8052"
id_input="8053"
timeout=2000
volume_input=$(amixer -D pulse get Capture | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1)
volume_output=$(amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1)

function get_volume {
    if [[ "$1" -eq 100 ]]; then $1=100; else $1=$(($1 + $amount)); fi
}

# Functions
function is_muted_input {
    amixer -D pulse get Capture | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function is_muted_output {
    amixer -D pulse get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function notification_bar {
    notify-send -u low -r "$id" -a "${header}" -i "${icon}" -h int:value:"$volume" "${text}" -t $timeout
}

function notification_mute {
    notify-send "$text" -u low -r $id -a "$header" -i "${icon}" -t $timeout
}

case $1 in
# Output
output-up)
    get_volume $volume_output
    volume=$volume_output
    header="Output volume"
    text="Currently at ${volume}%"
    icon="$icon_folder/vol-up.png"
    id=$id_output
	amixer -D pulse sset Master "$amount"%+
	notification_bar;;

output-down)
    volume=$(($volume_output - $amount))
    header="Output volume"
    text="Currently at ${volume}%"
    icon="$icon_folder/vol-down.png"
    id=$id_output
	amixer -D pulse sset Master "$amount"%-
	notification_bar;;

output-mute)
    if is_muted_output; then
        header="Output"
        text="Unmuted."
        icon="$icon_folder/vol.png"
        id=$id_output
        amixer -D pulse set Master 1+ toggle
        notification_mute
    else
        header="Output"
        text="Muted."
        icon="$icon_folder/vol-muted.png"
        id=$id_output
        amixer -D pulse set Master 1+ toggle
        notification_mute
    fi;;

# Input
input-up)
    get_volume $volume_input
    volume=$volume_input
    header="Input volume"
    text="Currently at ${volume}%"
    icon="$icon_folder/mic-up.png"
    id=$id_input
	amixer -D pulse sset Capture "$amount"%+
	notification_bar;;

input-down)
    volume=$(($volume_input - $amount))
    header="Input volume"
    text="Currently at ${volume}%"
    icon="$icon_folder/mic-down.png"
    id=$id_input
	amixer -D pulse sset Capture "$amount"%-
	notification_bar;;

input-mute)
    if is_muted_input; then
        header="Microphone"
        text="Unmuted."
        icon="$icon_folder/mic.png"
        id=$id_input
        amixer -D pulse set Capture 1+ toggle
        notification_mute
    else
        header="Microphone"
        text="Muted."
        icon="$icon_folder/mic-muted.png"
        id=$id_input
        amixer -D pulse set Capture 1+ toggle
        notification_mute
    fi;;
esac
