pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    implicitHeight: column.height

    Column {
        id: column
        anchors.centerIn: parent

        StyledText {
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter

            text: Time.time
            font.pixelSize: Config.style.font.size_big
            font.bold: true
            color: Colors.md3.surface_tint
        }

        StyledText {
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter

            text: Time.month
            font.pixelSize: Config.style.font.size_small
            color: Colors.md3.on_surface
        }
    }
}
