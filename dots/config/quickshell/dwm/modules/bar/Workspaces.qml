import qs.services
import qs.modules.shared
import Quickshell
import Quickshell.Hyprland
import QtQuick

Repeater {
    model: Hyprland.workspaces.values.filter(w => w.id > 0)

    delegate: Rectangle {
        width: Config.bar.height
        height: width

        color: modelData.active ? Colors.md3.primary : "transparent"

        StyledText {
            text: modelData.id
            color: modelData.active ? Colors.md3.on_primary : Colors.md3.on_surface
            anchors.centerIn: parent
        }
    }
}
