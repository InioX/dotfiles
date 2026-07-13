import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.modules.shared

RowLayout {
    id: root

    property string name: "No Name"
    property string description: "No Description provided"
    property bool showDescription: true

    ColumnLayout {

        StyledText {
            text: root.name
            color: Colors.md3.on_surface
            font.pixelSize: root.showDescription ? Config.style.font.size.small : Config.style.font.size.medium
        }

        StyledText {
            visible: root.showDescription
            text: root.description
            color: Colors.md3.outline_variant
            font.pixelSize: Config.style.font.size.small
        }
    }

    Item {
        Layout.fillWidth: true
    }
}
