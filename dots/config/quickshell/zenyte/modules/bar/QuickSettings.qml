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
            if (!qsPopoutLoader.active) {
                qsPopoutLoader.active = true;
            } else {
                if (qsPopoutLoader.item) {
                    qsPopoutLoader.item.isOpen = false;
                }
            }
        }
    }

    LazyLoader {
        id: qsPopoutLoader
        active: false
        component: QuickSettingsPopout {
            isOpen: qsPopoutLoader.active
            widgetX: background.mapToItem(null, background.width / 2, 0).x

            onAnimationCloseFinished: {
                qsPopoutLoader.active = false;
            }
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

        border.color: Colors.md3.outline_variant
        border.width: Config.bar.border_widgets ? 1 : 0

        Row {
            id: row
            anchors.centerIn: parent
            spacing: 10

            StyledAnimatedText {
                id: cameraIcon

                displayText: Camera.isShutterClosed ? "󰗟" : "󰄀"
                textColor: Colors.md3.on_surface
                fontSize: Config.style.font.size.icon_small
            }

            StyledAnimatedText {
                id: micIcon

                displayText: Pipewire.mutedSource ? "󰍭" : "󰍬"
                textColor: Colors.md3.on_surface
                fontSize: Config.style.font.size.icon_small
            }

            StyledAnimatedText {
                id: volumeIcon
                displayText: Pipewire.icon
                textColor: Colors.md3.on_surface
                fontSize: Config.style.font.size.icon_small
            }
        }
    }
}
