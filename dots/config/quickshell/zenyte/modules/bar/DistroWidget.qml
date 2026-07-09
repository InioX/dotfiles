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

    property bool closeBar: false

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
        function onRequestLauncherToggle(barWasAlreadyShowing) {
            root.closeBar = barWasAlreadyShowing;
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

        width: Config.bar.height - 22
        height: Config.bar.height - 22
        radius: width / 2

        color: distroMouseArea.containsMouse ? Colors.md3.secondary_container : Colors.md3.primary_container

        Behavior on color {
            StyledColorAnimation {}
        }

        StyledText {
            anchors.centerIn: parent
            text: ""

            color: distroMouseArea.containsMouse ? Colors.md3.on_secondary_container : Colors.md3.on_primary_container

            font.bold: true
            font.pixelSize: Config.style.font.size.icon
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
                console.log("finished");
                States.isLauncherOpened = false;
                launcherPopoutLoader.active = false;
            }
        }
    }
}
