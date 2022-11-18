#!/bin/bash
#Usage: ./brightness.sh [brightness-up / brightness-down / brightness-mute] [int]
#Usage: ./brightness.sh [temperature-up / temperature-down / temperature-mute] [int]

dir=`dirname "$0"`
amount=$2
id_brightness="8054"
id_temperature="8055"

# Functions
function value_temperature {
    timeout 0.01 wl-gammarelay --subscribe Temperature &
}

function value_brightness {
    timeout 0.01 wl-gammarelay --subscribe Brightness &
}

function notification_bar {
    dunstify -u low -r "$id" -h int:value:"$value" ${text}
}

case $1 in
# Brightness
brightness-up)
    value=`expr $(value_brightness)*100/1 | bc`
    text="Brightness: ${value}%"
    id=$id_brightness
	busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateBrightness d +${amount}
	notification_bar;;

brightness-down)
    value=`expr $(value_brightness)*100/1 | bc`
    text="Brightness: ${value}%"
    id=$id_brightness
	busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateBrightness d -${amount}
	notification_bar;;

# Temperature
temperature-up)
    value=$(value_temperature)
    text="Temperature: ${value}K"
    id=$id_temperature
    busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n +${amount}
	notification_bar;;

temperature-down)
    value=$(value_temperature)
    text="Temperature: ${value}K"
    id=$id_temperature
    busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n -${amount}
	notification_bar;;
esac
