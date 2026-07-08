// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    implicitHeight: background.height
    implicitWidth: background.width

    Rectangle {
        id: background

        width: 40
        height: 40
        radius: width / 2

        border.color: Colors.md3.outline_variant
        border.width: Config.bar.border_widgets ? 1 : 0

        color: recordingMouseArea.containsMouse ? Colors.md3.surface_container_high : Colors.md3.surface_container

        Behavior on color {
            StyledColorAnimation {}
        }

        StyledText {
            anchors.centerIn: parent
            text: ""

            color: recordingMouseArea.containsMouse ? Colors.md3.on_surface : Colors.md3.on_surface

            font.pixelSize: Config.style.font.size.icon_small
        }
    }

    StyledMouseArea {
        id: recordingMouseArea

        onClicked: {}
    }
}
