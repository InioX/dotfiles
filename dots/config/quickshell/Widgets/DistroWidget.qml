import "../Services"
import QtQuick

Rectangle {
    id: iconBg

    // property bool pulsing: root.launcherVisible
    property bool pulsing: false
    property var primaryContainerFocusedBg: root.launcherVisible ? Colors.md3.primary : ((mouseArea.containsMouse ? root.primaryTonalButtonHoverColor : Colors.md3.primary_container))
    property var primaryContainerFocusedFg: root.launcherVisible ? Colors.md3.on_primary : Colors.md3.on_primary_container
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

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: {
            root.launcherVisible = !root.launcherVisible;
        }
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }

}
