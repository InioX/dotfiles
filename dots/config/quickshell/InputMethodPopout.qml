import "./Services"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import QtQuick.Shapes
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets

WlrLayershell {
    id: qsPopout

    layer: WlrLayer.Overlay
    implicitWidth: 520
    implicitHeight: 320
    color: "transparent"
    exclusionMode: ExclusionMode.Normal
    margins.top: screen.height / 12
    margins.right: 10

    anchors {
        top: true
        right: true
    }

    Rectangle {
        id: background

        anchors.fill: parent
        color: Colors.md3.surface
        radius: 20
        border.color: Colors.md3.outline_variant
        border.width: 1

        ColumnLayout {
            id: layout

            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 20

            Text {
                text: "input"
                color: Colors.md3.on_surface
            }

        }

    }

}
