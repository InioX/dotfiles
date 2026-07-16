import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.modules.shared

Button {
    id: root
    implicitHeight: 60

    property bool enabled: false
    property string buttonIcon: ""
    property string name: ""

    property string enabledText: "On"
    property string disabledText: "Off"

    leftPadding: 10

    background: Rectangle {
        radius: Config.style.radius.qs_button
        color: root.enabled ? Colors.md3.primary : Colors.md3.surface_container

        Behavior on color {
            StyledColorAnimation {}
        }
    }

    contentItem: RowLayout {
        Layout.alignment: Qt.AlignVCenter

        spacing: 8

        StyledText {
            text: root.buttonIcon
            color: root.enabled ? Colors.md3.on_primary : Colors.md3.on_surface
            font.pixelSize: Config.style.font.size.icon_medium
        }

        ColumnLayout {
            spacing: 0

            Layout.alignment: Qt.AlignVCenter

            StyledText {
                text: root.name
                color: root.enabled ? Colors.md3.on_primary : Colors.md3.on_surface
                font.pixelSize: Config.style.font.size.medium
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
            }

            StyledText {
                text: root.enabled ? root.enabledText : root.disabledText
                color: root.enabled ? Colors.md3.on_primary : Colors.md3.on_surface_variant
                font.pixelSize: Config.style.font.size.small
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
            }
        }
    }
}
