import "../Services"
import QtQuick

Rectangle {
    readonly property int size: Math.max(layout.width, layout.height)

    width: size
    height: size
    radius: width / 2
    color: colors.primary_container

    Text {
        id: layout

        anchors.centerIn: parent
        text: root.distroIcon
        color: colors.on_primary_container
        font.bold: true
        font.pixelSize: root.iconSize + 7.5
    }

}
