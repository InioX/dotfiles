#!/bin/bash

main() {
  # open obtainium
  adb shell am start -n dev.imranr.obtainium/.MainActivity | sleep 1
  push_backup $1
  import_backup
  install_backup
}

set_wallpaper() {
  adb shell am start -n com.android.settings/com.example.test.MainActivity
}

push_backup() {
  adb push $1 /sdcard/1backups/
}

grab_screen() {
  adb pull $(adb shell uiautomator dump | grep -Po '[^ ]+.xml') /tmp/$1.xml > /dev/null
}

import_backup() {
    # go to Import/Export tab
    grab_screen view
    coords=$(grep -Po 'content-desc="Import/Export.*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords

    # go to Obtanium Import button
    grab_screen view
    coords=$(grep -Po 'content-desc="Obtainium Import".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords

    # using AOSP file picker 
    # navigate to exported json
    grab_screen view
    coords=$(grep -Po 'content-desc="Show roots".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords

    # index="6" may be different on your phone
    grab_screen view
    coords=$(grep -Po 'index="6" text="" resource-id="".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords

    # go to where backup json is located
    grab_screen view
    coords=$(grep -Po 'text="1backups".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords

    # select backup json
    grab_screen view
    coords=$(grep -Po 'text="obtainium-export.json".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords

    # go back to main Apps tab
    grab_screen view
    coords=$(grep -Po 'content-desc="Apps.*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords

    # sleep so imported apps pop up can dissapear, so it doesnt mess with the button index's
    sleep 2
}

install_backup() {
    # goto filter tab
    grab_screen view
    coords=$(grep -Po 'NAF="true" index="2".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords && sleep 0.5

    # set filter to only show uninstalled apps
    grab_screen view
    coords=$(grep -Po 'NAF="true" index="3" text="" resource-id="" class="android.widget.Switch".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords && sleep 0.5

    # click continue 
    grab_screen view
    coords=$(grep -Po 'content-desc="Continue".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords && sleep 0.5

    # grab amount of uninstalled pkgs
    grab_screen installs
    grep -Po 'index="1" text="" resource-id="" class="android.widget.Button".*' /tmp/installs.xml | grep -Po 'content-desc="(\d+)"' | head -1 | grep -Po '(\d+)' > base_installs
    base_installs=$(cat base_installs)

    # download all apks from import
    grab_screen view
    coords=$(grep -Po 'NAF="true" index="3".*' /tmp/view.xml | grep -Po '\[\d+,\d+\]\[\d+,\d+\]' | head -1 | sed 's/\[//g' | sed 's/\]/ /g' | sed 's/,/ /g' | awk '{printf ("%d %d\n", ($1+$3)/2, ($2+$4)/2)}')
    adb shell input tap $coords && sleep 0.5

    # press continue on download button
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
    echo "Done 'Choosing' Apks"

    # install apks
    echo "Installing Apps"

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
    echo "Done Installing Apps"
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