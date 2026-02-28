import "../Services"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

Column {
    id: clockRoot

    Text {
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter
        text: TimeService.time
        color: colors.surface_tint
        font.bold: true
        font.pixelSize: 18
    }

    Text {
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter
        text: TimeService.month
        color: colors.on_surface
        font.pixelSize: 12
    }

}
