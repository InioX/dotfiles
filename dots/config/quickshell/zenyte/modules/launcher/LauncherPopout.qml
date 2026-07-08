// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    property bool isOpen: false
    required property int widgetX

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

        wantedHeight: Math.max(10, column.implicitHeight + 60)
        wantedWidth: 500

        parentX: widgetX - (wantedWidth / 2)

        StyledRoundRect {
            id: rect

            ColumnLayout {
                id: column

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top

                spacing: 20
                anchors.margins: 20

                StyledText {
                    text: "Hello, World!"
                }
            }
        }
    }
}
