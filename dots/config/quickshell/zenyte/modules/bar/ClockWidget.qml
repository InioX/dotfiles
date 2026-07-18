// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    implicitHeight: column.height
    implicitWidth: column.width + 10

    property bool alignCenter: false

    Column {
        id: column
        anchors.centerIn: parent
        spacing: 0

        Rectangle {
            width: timeText.width
            height: timeText.height
            radius: 10

            Behavior on color {
                StyledColorAnimation {}
            }

            StyledMouseArea {
                id: timeMouseArea
                anchors.fill: parent
            }

            color: timeMouseArea.containsMouse ? Colors.md3.surface_container_high : "transparent"

            StyledText {
                id: timeText
                anchors.horizontalCenter: alignCenter ? column.horizontalCenter : undefined

                text: Time.time
                font.pixelSize: Config.style.font.size.big
                font.bold: true
                color: Colors.md3.on_surface
            }
        }

        Rectangle {
            width: dateText.width
            height: dateText.height
            radius: 10

            Behavior on color {
                StyledColorAnimation {}
            }

            StyledMouseArea {
                id: dateMouseArea
                anchors.fill: parent
            }
            color: dateMouseArea.containsMouse ? Colors.md3.surface_container_high : "transparent"

            StyledText {
                id: dateText
                anchors.horizontalCenter: alignCenter ? column.horizontalCenter : undefined

                text: Time.month
                font.pixelSize: Config.style.font.size.small
                color: Colors.md3.outline
            }
        }
    }
}
