// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import qs.modules.soundSettings
import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property bool shouldHighlightBackground: {
        if (soundSettingsMouseArea.containsMouse) {
            return true;
        }
        if (soundPopoutLoader.active) {
            return true;
        }

        return false;
    }

    function open() {
        if (!soundPopoutLoader.active) {
            soundPopoutLoader.active = true;
        } else {
            if (soundPopoutLoader.item) {
                soundPopoutLoader.item.isOpen = false;
            }
        }
    }

    implicitHeight: 40
    implicitWidth: background.width

    StyledMouseArea {
        id: soundSettingsMouseArea

        anchors.fill: parent
        onClicked: {
            root.open();
        }
    }

    Connections {
        target: States
        function onRequestSoundSettingsToggle() {
            delayTimer.running = !delayTimer.running;
        }
    }

    Timer {
        id: delayTimer
        interval: 100
        onTriggered: root.open()
    }

    LazyLoader {
        id: soundPopoutLoader
        active: false
        component: SoundSettingsPopout {
            isOpen: soundPopoutLoader.active
            widgetX: background.mapToItem(null, background.width / 2, 0).x

            onAnimationCloseFinished: {
                States.isSoundSettingsOpened = false;
                soundPopoutLoader.active = false;
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
