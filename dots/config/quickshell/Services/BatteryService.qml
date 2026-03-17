import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
pragma Singleton

Singleton {
    // return {
    //     "fg": "#46D47D",
    //     "bg": "#285B39"
    // }

    id: root

    property var currentProfile: PowerProfiles.profile
    readonly property var state: UPower.displayDevice.state
    readonly property real value: UPower.displayDevice.percentage
    readonly property var colors: {
        if (state === UPowerDeviceState.Charging || state === UPowerDeviceState.FullyCharged)
            return {
            "fg": "#46D47D",
            "bg": "#285B39"
        };
        else if (value <= 0.2)
            return {
            "fg": "#f05454",
            "bg": "#4D2F2F"
        };
        else
            return {
            "fg": Colors.md3.on_surface_container,
            "bg": Colors.md3.surface_container_highest
        };
    }
}
