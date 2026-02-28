import "../Services"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

Rectangle {
    color: colors.error
    width: 50
    height: 50
    radius: 16

    Text {
        id: text

        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        text: "󰐥"
        color: colors.on_error
        font.bold: true
        font.pixelSize: 30
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.powerMenuVisible = !root.powerMenuVisible;
        }
    }

}
