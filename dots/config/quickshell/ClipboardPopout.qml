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

    anchors {
        top: true
        right: true
    }

    Rectangle {
        id: background

        anchors.fill: parent
        color: Colors.md3.surface
        bottomLeftRadius: 20

        ColumnLayout {
            id: layout

            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 20

            Text {
                text: "clipboard"
                color: Colors.md3.on_surface
            }

        }

    }

}
