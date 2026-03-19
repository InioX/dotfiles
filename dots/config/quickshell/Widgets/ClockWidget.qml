import "../Services"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

Rectangle {
    property real margin: 8

    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter
    color: mouseArea.containsMouse ? Colors.md3.surface_container : "transparent"
    width: clockRoot.width + margin * 2
    height: clockRoot.height + margin * 2
    radius: root.cornerRadius

    Column {
        id: clockRoot

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Text {
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: TimeService.time
            color: Colors.md3.surface_tint
            font.bold: true
            font.pixelSize: 18
        }

        Text {
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            text: TimeService.month
            color: Colors.md3.on_surface
            font.pixelSize: 12
        }

    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }

}
