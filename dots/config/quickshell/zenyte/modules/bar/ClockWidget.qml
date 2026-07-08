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
    implicitWidth: column.width

    property bool alignCenter: false

    Column {
        id: column
        anchors.centerIn: parent

        spacing: 0

        StyledText {
            anchors.horizontalCenter: alignCenter ? column.horizontalCenter : undefined

            text: Time.time
            font.pixelSize: Config.style.font.size.big
            font.bold: true
            color: Colors.md3.on_surface
        }

        StyledText {
            anchors.horizontalCenter: alignCenter ? column.horizontalCenter : undefined

            text: Time.month
            font.pixelSize: Config.style.font.size.small
            color: Colors.md3.outline
        }
    }

    StyledMouseArea {
        id: clockMouseArea

        anchors.fill: parent
    }
}
