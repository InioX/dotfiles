import qs.services
import qs.modules.shared
import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
    Layout.fillWidth: true
    Layout.fillHeight: true
    spacing: 0

    Repeater {
        model: Hyprland.focusedWorkspace?.toplevels

        delegate: Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true

            color: modelData.activated ? Colors.md3.primary : Colors.md3.surface_container

            StyledText {
                id: text
                text: modelData.title
                color: modelData.activated ? Colors.md3.on_primary : Colors.md3.on_surface

                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.right: parent.right
                anchors.rightMargin: 8
                anchors.verticalCenter: parent.verticalCenter

                elide: Text.ElideRight
            }
        }
    }
}
