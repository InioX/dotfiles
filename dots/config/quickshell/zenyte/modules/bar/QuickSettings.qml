// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    implicitHeight: 30
    implicitWidth: background.width

    StyledMouseArea {
        id: quickSettingsMouseArea

        anchors.fill: parent
    }

    Rectangle {
        id: background

        anchors.fill: parent

        Behavior on color {
            StyledColorAnimation {}
        }

        color: quickSettingsMouseArea.containsMouse ? Colors.md3.surface_container_high : Colors.md3.surface_container
        width: row.width + 40
        radius: Config.style.rounding.small

        Row {
            id: row
            anchors.centerIn: parent
            spacing: 10

            StyledText {
                id: cameraIcon

                text: Camera.isShutterClosed ? "󰗟" : "󰄀"
                color: Colors.md3.on_surface
                font.pixelSize: Config.style.font.size.big
            }

            StyledText {
                id: micIcon

                text: Pipewire.mutedSource ? "󰍭" : "󰍬"
                color: Colors.md3.on_surface
                font.pixelSize: Config.style.font.size.big
            }
            StyledText {
                id: volumeIcon

                text: Pipewire.icon
                color: Colors.md3.on_surface
                font.pixelSize: Config.style.font.size.big
            }
        }
    }
}
