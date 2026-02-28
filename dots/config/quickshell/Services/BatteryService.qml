import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
pragma Singleton

Singleton {
    id: root

    property var device: UPower.displayDevice
    property real ratio: device ? device.percentage : 0
    property int percentage: Math.round(ratio * 100)
}
