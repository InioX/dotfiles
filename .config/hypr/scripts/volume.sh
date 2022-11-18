#!/bin/bash
#Usage: ./volume.sh [output-up / output-down / output-mute] [int]
#Usage: ./volume.sh [input-up / input-down / input-mute] [int]

dir=`dirname "$0"`
amount=$2
id_output="8052"
id_input="8053"

# Functions
function volume_input {
    amixer -D pulse get Capture | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function volume_output {
    amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_muted_input {
    amixer -D pulse get Capture | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function is_muted_output {
    amixer -D pulse get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function notification_bar {
    dunstify -u low -r "$id" -h int:value:"$volume" ${text}
}

function notification_mute {
    notify-send "$text" -u low -r $id
}

case $1 in
# Output
output-up)
    volume=$(volume_output)
    text="Volume: ${volume}%"
    id=$id_output
	amixer -D pulse sset Master "$amount"%+
	notification_bar;;

output-down)
    volume=$(volume_output)
    text="Volume: ${volume}%"
    id=$id_output
	amixer -D pulse sset Master "$amount"%-
	notification_bar;;

output-mute)
    id=$id_output
    if is_muted_output; then
        text="Volume unmuted"
        amixer -D pulse set Master 1+ toggle
        notification_mute
    else
        text="Volume muted"
        amixer -D pulse set Master 1+ toggle
        notification_mute
    fi;;

# Input
input-up)
    volume=$(volume_input)
    text="ﱛ Microphone: $volume%"
    id=$id_input
	amixer -D pulse sset Capture "$amount"%+
	notification_bar;;

input-down)
    volume=$(volume_input)
    text="ﱜ Microphone: $volume%"
    id=$id_input
	amixer -D pulse sset Capture "$amount"%-
	notification_bar;;

input-mute)
    id=$id_input
    if is_muted_input; then
        text="Microphone unmuted"
        amixer -D pulse set Capture 1+ toggle
        notification_mute
    else
        text="Microphone muted"
        amixer -D pulse set Capture 1+ toggle
        notification_mute
    fi;;
esac
