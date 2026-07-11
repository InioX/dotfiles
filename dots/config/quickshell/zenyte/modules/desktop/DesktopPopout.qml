// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import Quickshell
import Quickshell.Services.Pipewire as QsPipewire
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    property bool isOpen: false
    required property int widgetX
    required property int widgetY

    signal animationCloseFinished

    Timer {
        id: destroyTimer
        interval: 150
        onTriggered: root.animationCloseFinished()
    }

    onIsOpenChanged: {
        if (!isOpen) {
            destroyTimer.start();
        } else {
            destroyTimer.stop();
        }
    }

    StyledPopout {
        isOpen: root.isOpen

        wantedHeight: column.implicitHeight + 60
        wantedWidth: 300

        anchor.rect.x: widgetX
        anchor.rect.y: widgetY

        anchor.window: wallpaperLayer

        StyledRoundRect {
            id: rect

            StyledMouseArea {
                id: desktopPopoutMouseArea
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                anchors.fill: parent

                cursorShape: Qt.Normal

                onClicked: mouse => {
                    if (mouse.button === Qt.RightButton) {
                        root.isOpen = false;
                    }
                }
            }

            ColumnLayout {
                id: column

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top

                spacing: 20
                anchors.margins: 20
            }
        }
    }
}
