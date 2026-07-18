#!/usr/bin/env bash
#Usage: ./volume.sh [output-up / output-down / output-mute] [int]
#Usage: ./volume.sh [input-up / input-down / input-mute] [int]

dir=`dirname "$0"`
icon_folder="~/.config/hypr/icons"
amount=$2
id_output="8052"
id_input="8053"
timeout=2000
volume_output=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)
volume_input=$(pactl get-source-volume @DEFAULT_SOURCE@ | grep -Po '\d+(?=%)' | head -n 1)
is_muted_output=$(pactl get-sink-mute @DEFAULT_SINK@)
is_muted_input=$(pactl get-source-mute @DEFAULT_SOURCE@)

function notification_bar {
    notify-send -u low -r "$id" -a "${header}" -i "${icon}" -h int:value:"$volume" "${text}" -t $timeout -a "progress"
}

function notification_mute {
    notify-send "$text" -u low -r $id -a "$header" -i "${icon}" -t $timeout -a "progress"
}

case $1 in
# Output
output-up)
	pactl set-sink-volume @DEFAULT_SINK@ +$amount%
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)
    header="Output volume"
    text="Currently at ${volume}%"
    icon="$icon_folder/vol-up.png"
    id=$id_output
	notification_bar;;

output-down)
	pactl set-sink-volume @DEFAULT_SINK@ -$amount%
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)
    header="Output volume"
    text="Currently at ${volume}%"
    icon="$icon_folder/vol-down.png"
    id=$id_output
	notification_bar;;

output-mute)
    echo $is_muted_output
    if [ "$is_muted_output" == "Mute: yes" ]; then
        header="Output"
        text="Unmuted."
        icon="$icon_folder/vol.png"
        id=$id_output
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        notification_mute
    else
        header="Output"
        text="Muted."
        icon="$icon_folder/vol-muted.png"
        id=$id_output
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        notification_mute
    fi;;

# Input
input-up)
	pactl set-source-volume @DEFAULT_SOURCE@ +$amount%
    volume=$(pactl get-source-volume @DEFAULT_SOURCE@ | grep -Po '\d+(?=%)' | head -n 1)
    header="Input volume"
    text="Currently at ${volume}%"
    icon="$icon_folder/mic-up.png"
    id=$id_input
	notification_bar;;

input-down)
	pactl set-source-volume @DEFAULT_SOURCE@ -$amount%
    volume=$(pactl get-source-volume @DEFAULT_SOURCE@ | grep -Po '\d+(?=%)' | head -n 1)
    header="Input volume"
    text="Currently at ${volume}%"
    icon="$icon_folder/mic-down.png"
    id=$id_input
	notification_bar;;

input-mute)
    if [ "$is_muted_input" == "Mute: yes" ]; then
        header="Microphone"
        text="Unmuted."
        icon="$icon_folder/mic.png"
        id=$id_input
        pactl set-source-mute @DEFAULT_SOURCE@ toggle
        notification_mute
    else
        header="Microphone"
        text="Muted."
        icon="$icon_folder/mic-muted.png"
        id=$id_input
        pactl set-source-mute @DEFAULT_SOURCE@ toggle
        notification_mute
    fi;;
esac
