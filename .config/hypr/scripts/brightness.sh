#!/bin/bash
#Usage: ./brightness.sh [brightness-up / brightness-down / brightness-mute] [int]
#Usage: ./brightness.sh [temperature-up / temperature-down / temperature-mute] [int]

dir=`dirname "$0"`
icon_folder="~/.config/hypr/icons"
amount=$2
id_brightness="8054"
id_temperature="8055"
value_brightness=`timeout 0.01 wl-gammarelay --subscribe Brightness &`
value_temperature=`timeout 0.01 wl-gammarelay --subscribe Temperature &`

# Functions
function get_value {
    local percentage=`expr $1*100/1 | bc`
    if [[ "$percentage" -eq 100 ]]; then
        value=100 
    elif [[ "$percentage" -eq 0 ]]; then
        value=0
    else
        value=$percentage
    fi
}

function notification_bar {
    dunstify -u low -r "$id" -h int:value:"$value" "${text}" -a "${header}" -i "${icon}"
}

case $1 in
# Brightness
brightness-up)
    get_value $value_brightness
    # value=$(get_percentage $value_brightness)
    header="Brightness"
    text="Currently at ${value}%"
    icon="$icon_folder/brightness-up.png"
    id=$id_brightness
	busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateBrightness d +${amount}
	notification_bar;;

brightness-down)
    get_value $value_brightness
    header="Brightness"
    text="Currently at ${value}%"
    icon="$icon_folder/brightness-down.png"
    id=$id_brightness
	busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateBrightness d -${amount}
	notification_bar;;

# Temperature
temperature-up)
    value=$(($value_temperature + $amount))
    header="Temperature"
    text="Currently at ${value}K"
    icon="$icon_folder/temperature-up.png"
    id=$id_temperature
    busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n +${amount}
	notification_bar;;

temperature-down)
    value=$(($value_temperature - $amount))
    header="Temperature"
    text="Currently at ${value}K"
    icon="$icon_folder/temperature-down.png"
    id=$id_temperature
    busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n -${amount}
	notification_bar;;
esac
