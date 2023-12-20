#!/usr/bin/env bash
purple='\033[1;35m'
red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;94m'
grey='\033[90m'
normal='\033[0m'
bold='\033[1m'

main() {
  read -s -p "Github Token: " github_token
  echo ""

  setup_obtainium
  setup_termux
  configure_settings
}

setup_termux() {
  print_header "Running Termux Setup"

  print_text "Opening Termux"
  adb shell am start -n com.termux/com.termux.HomeActivity | sleep 5

  print_text "Setting Default Editor To Vim"
  adb shell input text "export%sEDITOR\\='vim'"
  adb shell input keyevent 66

  print_text "Running Termux Setup Script From GitHub"
  adb shell input text "bash%s\\<\\(curl%s\\-s%shttps://raw.githubusercontent.com/InioX/dotfiles/android/setup_termux.sh\\)"
  adb shell input keyevent 66

  adb shell input keyevent 66

  print_text "Waiting 25s For Packages To Finish Installing"
  sleep 25

  adb shell input text "i"

  adb shell input text "0%s1%s*%s*%s*%s\\~/dotfiles/auto_commit_dotfiles.sh"

  adb shell input keyevent 111  
  adb shell input text ":wq"
  adb shell input keyevent 66

  print_text "Waiting 25s For Git To Finish Cloning"
  sleep 25

  adb shell input keyevent 66
  adb shell input keyevent 66
  adb shell input text "y"
  adb shell input keyevent 66

  adb shell input keyevent 20
  adb shell input keyevent 66

  adb shell input text $github_token
  adb shell input keyevent 66

  print_text "Waiting 5s For The File Dialog"
  sleep 5
  grab_screen view
  coords=$(grep -Po 'resource-id="com.android.permissioncontroller:id/permission_allow_button".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
  adb shell input tap $coords
}

setup_obtainium() {
  print_header "Running Obtainium Setup"
  temp_file=$(mktemp)
  echo $(curl -s https://raw.githubusercontent.com/InioX/dotfiles/android/obtainium-export.json) >> $temp_file

  adb shell am start -n dev.imranr.obtainium/.MainActivity | sleep 1
  push_backup $temp_file
  import_backup
  sleep 2
  install_backup
  rm $temp_file
}

print_header() {
  header=$1
  echo -e "${purple}==>${normal} ${bold}$header...${normal}"
  sleep 0.3
}

print_text() {
  echo -e "${blue}::${normal} ${bold}$1...${normal}"
}

open_browser() {
    print_header "Opening Browser"
    adb shell am start -a android.intent.action.VIEW -d $1
}

press_key_combination() {
  adb shell sendevent /dev/input/event0 1 $1 1
  adb shell sendevent /dev/input/event0 0 0 0
  adb shell sendevent /dev/input/event0 1 $2 1
  adb shell sendevent /dev/input/event0 0 0 0
  adb shell sendevent /dev/input/event0 1 $1 0
  adb shell sendevent /dev/input/event0 0 0 0
  adb shell sendevent /dev/input/event0 1 $2 0
  adb shell sendevent /dev/input/event0 0 0 0
}

set_wallpaper() {
  adb shell am start -n com.android.settings/com.example.test.MainActivity
}

push_backup() {
  adb push $1 /sdcard/1backups/obtainium-export.json
}

grab_screen() {
  adb pull $(adb shell uiautomator dump | grep -Po '[^ ]+.xml') /tmp/$1.xml > /dev/null
}

import_backup() {
    print_header "Importing Obtainium Backup"
    print_text "Going To Import/Export Tab"
    grab_screen view
    coords=$(grep -Po 'content-desc="Import/Export.*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords

    print_text "Going To Obtanium Import Button"
    grab_screen view
    coords=$(grep -Po 'content-desc="Obtainium Import".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords

    print_text "Going To Exported JSON Using AOSP File Picker"
    grab_screen view
    coords=$(grep -Po 'content-desc="Show roots".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords

    # index="6" may be different on your phone
    print_text "Going To Home Directory"
    grab_screen view
    coords=$(grep -Po 'index="6" text="" resource-id="".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords

    print_text "Going To Folder Where obtainium-export.json Is Located"
    grab_screen view
    coords=$(grep -Po 'text="1backups".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords

    print_text "Selecting The obtainium-export.json File."
    grab_screen view
    coords=$(grep -Po 'text="obtainium-export.json".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords

    print_text "Going Back To Main Apps Tab"
    grab_screen view
    coords=$(grep -Po 'content-desc="Apps.*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords

    # sleep so imported apps pop up can dissapear, so it doesnt mess with the button index's
    sleep 2
}

install_backup() {
    print_header "Installing Apps In Obtainium"
    
    print_text "Going To Filter Tab"
    grab_screen view
    coords=$(grep -Po 'NAF="true" index="2".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords && sleep 0.5

    print_text "Setting Filter To Only Show Uninstalled Apps"
    grab_screen view
    coords=$(grep -Po 'NAF="true" index="3" text="" resource-id="" class="android.widget.Switch".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords && sleep 0.5

    print_text "Clicking Continue"
    grab_screen view
    coords=$(grep -Po 'content-desc="Continue".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords && sleep 0.5

    print_text "Grabbing The Amount Of Uninstalled Apps"
    grab_screen installs
    grep -Po 'index="1" text="" resource-id="" class="android.widget.Button".*' /tmp/installs.xml | grep -Po 'content-desc="(\d+)"' | head -1 | grep -Po '(\d+)' > base_installs
    base_installs=$(cat base_installs)

    print_text "Downloading All Apps From Import"
    grab_screen view
    coords=$(grep -Po 'NAF="true" index="3".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords && sleep 0.5

    print_text "Pressing Continue On Download Button"
    adb shell input keyevent 22 && sleep 0.2
    adb shell input keyevent 22 && sleep 0.2
    adb shell input keyevent 22 && sleep 0.2
    adb shell input keyevent 66

    grab_screen view
    pick_apk_exists=true

    adb logcat -c
    check_apk
    while [ "$pick_apk_exists" == "true"  ] 
    do 
    grab_screen continue
    continuee=$(grep -Po 'content-desc="Continue".*' /tmp/continue.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    #echo "/$continuee"
    adb shell input tap $continuee && sleep 0.5
    check_apk
    done
    print_text "Done 'Choosing' Apks"

    # install apks
    print_text "Installing Apps"

    current_installs_left=$base_installs
    logfile=packageoverlayed

    is_pkg_ready

    while [ "$current_installs_left" -ne 0 ] 
    do 
        if [[ -z $(grep '[[:space:]]' $logfile) ]]
        then
        is_pkg_ready
        else
        grab_screen view
        coords=$(grep -Po 'text="Install.*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
        adb shell input tap $coords && sleep 0.5
        sleep 1
        current_installs_left=$[$current_installs_left-1] 
        echo "$current_installs_left/$base_installs left to install"
        > packageoverlayed
        adb logcat -c
        fi
    done
    print_text "Done Installing Apps"
}

check_apk() {
    grab_screen apk
    grep -Po 'content-desc="Pick an APK".*' /tmp/apk.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}' > pick-apk
    if [[ -z $(grep '[[:space:]]' pick-apk) ]] 
    then 
    pick_apk_exists=false
    else
    pick_apk_exists=true
    fi
}

is_pkg_ready() {
    adb logcat -s ActivityTaskManager -v raw -d | grep -e "Displayed com.android.packageinstaller" > packageoverlayed
}

configure_single_setting() {
  adb shell settings put $1 $2 $3
  echo $2=$3
}

configure_settings() {
    print_header "Configuring Settings"

    print_text "Setting Night Display"
    configure_single_setting "secure" "night_display_activated" "1"
    configure_single_setting "secure" "night_display_auto_mode" "0"
    configure_single_setting "secure" "night_display_color_temperature" "2775"

    print_text "Setting Bluetooth Name"
    configure_single_setting "secure" "bluetooth_name" "RMX2155"

    # Make monet engine use wallpaper colors (some custom roms disable this)
    print_text "Enabling Monet"
    configure_single_setting "secure" "monet_engine_custom_bgcolor" "0"
    configure_single_setting "secure" "monet_engine_custom_color" "0"

    # Enables all privacy indicators in status bar
    print_text "Enabling Privacy Indicators"
    configure_single_setting "secure" "enable_camera_privacy_indicator" "1"
    configure_single_setting "secure" "enable_location_privacy_indicator" "1"
    configure_single_setting "secure" "enable_projection_privacy_indicator" "1"

    # Disables these icons in status bar
    print_text "Disabling Some Status Bar Icons"
    configure_single_setting "secure" "icon_blacklist" "ethernet,rotate,volume,ims,mute,call_strength"

    # Disable "three fingers to screenshot" finger gesture
    print_text "Setting Gestures"
    configure_single_setting "system" "three_finger_gesture" "0"

    # Sets the screen timeout to 2 minutes
    print_text "Setting Screen Timeout"
    configure_single_setting "system" "screen_off_timeout" "120000"

    # Sets the system languages
    print_text "Setting System Languages"
    configure_single_setting "system" "system_locales" "en-US,cs-CZ,ru-RU"

    # System animation speed (default, make this lower to feel faster, 0.0 will disable animations)
    print_text "Setting Animation Speed"
    configure_single_setting "system" "transition_animation_scale" "1.0"

    print_text "Setting Quick Settings Tiles"
    configure_single_setting "secure" "sysui_qs_tiles" "internet,bt,flashlight,rotation,night,caffeine,cameratoggle,mictoggle,screenrecord,location,custom(com.x8bit.bitwarden/.MyVaultTileService),dnd"

    print_text "Disabling Haptic Feedback"
    configure_single_setting "system" "haptic_feedback_enabled" "0"
}

main "$@"