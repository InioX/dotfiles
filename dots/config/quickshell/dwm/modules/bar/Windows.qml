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

        delegate: ColumnLayout {
            id: delegate
            required property var modelData

            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            // Rectangle {
            //     Layout.fillWidth: true
            //     Layout.preferredHeight: 2
            //     color: delegate.modelData.activated ? Colors.md3.primary : "transparent"
            // }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: delegate.modelData.activated ? Colors.md3.surface_container : "transparent"

                StyledText {
                    text: delegate.modelData.title
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
}
