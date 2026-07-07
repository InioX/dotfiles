import qs.services
import qs.modules.widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.LocalStorage
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Io

WlrLayershell {
    id: launcher

    property bool showWorkspaceNumber: false

    layer: WlrLayer.Overlay
    implicitWidth: layout.implicitWidth + 200
    implicitHeight: 100
    color: "transparent"
    exclusionMode: ExclusionMode.Normal

    anchors {
        bottom: true
        left: true
    }

    Rectangle {
        id: background

        anchors.bottomMargin: 20
        anchors.leftMargin: 10
        anchors.fill: parent
        color: Colors.md3.surface
        border.color: Colors.md3.outline_variant
        border.width: 1
        radius: 40

        RowLayout {
            // WorkspaceWidget {
            // }
            // Text {
            //     color: Colors.md3.outline_variant
            //     text: "|"
            //     font.pixelSize: 25
            //     verticalAlignment: Text.AlignVCenter
            //     font.bold: true
            // }

            id: layout

            anchors.fill: parent
            anchors.leftMargin: 14
            anchors.rightMargin: 14
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                color: Colors.md3.secondary_container
                implicitWidth: launcherIcon.width + 20
                implicitHeight: launcherIcon.height
                radius: 30

                Text {
                    id: launcherIcon

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    color: Colors.md3.on_secondary_container
                    text: "󰉋"
                    font.pixelSize: 40
                    verticalAlignment: Text.AlignVCenter
                }
            }

            ColumnLayout {

                Layout.fillWidth: true

                Text {
                    text: "hello"
                    color: Colors.md3.on_surface
                }

                Rectangle {
                    color: Colors.md3.surface_container_highest
                    Layout.fillWidth: true
                    implicitHeight: 6
                    radius: 20

                    Rectangle {
                        implicitWidth: parent.width * 0.4
                        radius: parent.radius
                        color: Colors.md3.primary

                        anchors {
                            left: parent.left
                            top: parent.top
                            bottom: parent.bottom
                        }
                    }
                }
            }
        }
    }
}
