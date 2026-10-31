pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower

Singleton {
    id: root

    property var currentProfile: PowerProfiles.profile
    readonly property var state: UPower.displayDevice.state
    readonly property real value: UPower.displayDevice.percentage
}
