import qs.services
import qs.modules.shared
import Quickshell
import QtQuick

Row {
    spacing: 10
    anchors.verticalCenter: parent.vericalCenter

    StyledText {
        text: Time.time
        color: Colors.md3.on_surface
    }

    StyledText {
        text: Time.month
        color: Colors.md3.on_surface
    }
}
