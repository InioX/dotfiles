// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import qs.modules.launcher
import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    implicitHeight: background.height
    implicitWidth: background.width

    property bool shouldHighlightBackground: {
        if (distroMouseArea.containsMouse) {
            return true;
        }
        if (launcherPopoutLoader.active) {
            return true;
        }

        return false;
    }

    function open() {
        if (!launcherPopoutLoader.active) {
            launcherPopoutLoader.active = true;
        } else {
            if (launcherPopoutLoader.item) {
                launcherPopoutLoader.item.isOpen = false;
            }
        }
    }

    Connections {
        target: States
        function onRequestLauncherToggle() {
            delayTimer.running = !delayTimer.running;
        }
    }

    Timer {
        id: delayTimer
        interval: 100
        onTriggered: root.open()
    }

    Rectangle {
        id: background

        width: 40
        height: 40
        radius: width / 2

        color: shouldHighlightBackground ? Colors.md3.primary : Colors.md3.primary_container

        Behavior on color {
            StyledColorAnimation {}
        }

        StyledText {
            anchors.centerIn: parent
            text: ""

            color: shouldHighlightBackground ? Colors.md3.on_primary : Colors.md3.on_primary_container

            font.bold: true
            font.pixelSize: Config.style.font.size.icon

            Behavior on color {
                StyledColorAnimation {}
            }
        }
    }

    StyledMouseArea {
        id: distroMouseArea

        onClicked: {
            root.open();
        }
    }

    LazyLoader {
        id: launcherPopoutLoader
        active: false
        component: LauncherPopout {
            isOpen: launcherPopoutLoader.active
            widgetX: background.mapToItem(null, background.width / 2, 0).x

            onAnimationCloseFinished: {
                States.isLauncherOpened = false;
                launcherPopoutLoader.active = false;
            }
        }
    }
}
