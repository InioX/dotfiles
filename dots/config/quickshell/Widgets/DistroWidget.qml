import "../Services"
import QtQuick

Rectangle {
    id: iconBg

    property bool pulsing: root.launcherVisible
    property var primaryContainerFocusedBg: root.launcherVisible ? colors.primary : colors.primary_container
    property var primaryContainerFocusedFg: root.launcherVisible ? colors.on_primary : colors.on_primary_container
    readonly property int size: Math.max(layout.width, layout.height)

    width: size
    height: size
    radius: width / 2
    color: primaryContainerFocusedBg

    Item {
        id: rotWrapper

        anchors.centerIn: parent
        width: iconBg.width
        height: iconBg.height

        Text {
            id: layout

            anchors.centerIn: parent
            text: root.distroIcon
            font.pixelSize: root.iconSize + 7.5
            font.bold: true
            color: primaryContainerFocusedFg
        }

        SequentialAnimation on scale {
            loops: Animation.Infinite
            running: iconBg.pulsing

            NumberAnimation {
                from: 1
                to: 1.1
                duration: 700
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                from: 1.1
                to: 1
                duration: 700
                easing.type: Easing.InOutQuad
            }

        }

    }

}
