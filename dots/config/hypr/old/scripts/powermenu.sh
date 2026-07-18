#!/usr/bin/env bash
 
# Options for powermenu
lock=" Lock"
logout=" Logout"
shutdown=" Shutdown"
reboot="󰜉 Restart"
reboot_windows=" Windows 11"
sleep=" Sleep"
 
# Get answer from user via rofi
selected_option=$(echo "$shutdown
$reboot
$reboot_windows
$lock
$logout
$sleep" | rofi -dmenu\
                  -i\
                  -p "Power"\
		  -theme "~/.config/rofi/menu.rasi")
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
elif [ "$selected_option" == "$reboot_windows" ]
then
    systemctl reboot --boot-loader-entry=auto-windows
elif [ "$selected_option" == "$sleep" ]
then
    amixer set Master mute
    systemctl suspend
else
    echo "No match"
fi
