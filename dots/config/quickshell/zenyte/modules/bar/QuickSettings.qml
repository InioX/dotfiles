// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import qs.modules.quickSettings
import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property bool shouldHighlightBackground: {
        if (quickSettingsMouseArea.containsMouse) {
            return true;
        }
        if (qsPopoutLoader.active) {
            return true;
        }

        return false;
    }

    implicitHeight: 40
    implicitWidth: background.width

    StyledMouseArea {
        id: quickSettingsMouseArea

        anchors.fill: parent
        onClicked: {
            qsPopoutLoader.active = !qsPopoutLoader.active;
        }
    }

    LazyLoader {
        id: qsPopoutLoader
        active: false
        component: QuickSettingsPopout {
            isOpen: qsPopoutLoader.active
        }
    }

    Rectangle {
        id: background

        anchors.fill: parent

        Behavior on color {
            StyledColorAnimation {}
        }

        color: shouldHighlightBackground ? Colors.md3.surface_container_high : Colors.md3.surface_container
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
                font.pixelSize: Config.style.font.size.icon_small
            }

            StyledText {
                id: micIcon

                text: Pipewire.mutedSource ? "󰍭" : "󰍬"
                color: Colors.md3.on_surface
                font.pixelSize: Config.style.font.size.icon_small
            }
            StyledText {
                id: volumeIcon

                text: Pipewire.icon
                color: Colors.md3.on_surface
                font.pixelSize: Config.style.font.size.icon_small
            }
        }
    }
}
