// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    implicitHeight: background.height
    implicitWidth: background.width

    Rectangle {
        id: background

        width: Config.bar.height - 22
        height: Config.bar.height - 22
        radius: width / 2

        color: Colors.md3.primary_container

        StyledText {
            anchors.centerIn: parent
            text: ""

            color: Colors.md3.on_primary_container
            font.bold: true
            font.pixelSize: Config.style.font.size.icon
        }
    }

    StyledMouseArea {
        id: distroMouseArea
    }
}
