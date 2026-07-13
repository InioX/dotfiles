import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.modules.shared
import qs.services

ColumnLayout {
    property string text: "No Title"

    StyledText {
        text: "Basic Settings"
        color: Colors.md3.on_surface
        font.pixelSize: Config.style.font.size.big
    }

    StyledSeparator {
        Layout.fillWidth: true
    }
}
