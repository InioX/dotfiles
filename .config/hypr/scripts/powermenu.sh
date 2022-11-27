#!/bin/env bash
 
# Options for powermenu
lock=" Lock"
logout=" Logout"
shutdown=" Shutdown"
reboot=" Restart"
sleep=" Sleep"
 
# Get answer from user via rofi
selected_option=$(echo "$lock
$logout
$sleep
$reboot
$shutdown" | rofi -dmenu\
                  -i\
                  -p "Power"\
		  -theme "~/.config/hypr/rofi/powermenu.rasi")
# Do something based on selected option
if [ "$selected_option" == "$lock" ]
then
    ~/.config/hypr/scripts/lockscreen.sh
elif [ "$selected_option" == "$logout" ]
then
    loginctl terminate-user `whoami`
elif [ "$selected_option" == "$shutdown" ]
then
    systemctl poweroff
elif [ "$selected_option" == "$reboot" ]
then
    systemctl reboot
elif [ "$selected_option" == "$sleep" ]
then
    amixer set Master mute
    systemctl suspend
else
    echo "No match"
fi
