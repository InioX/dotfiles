import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets

WlrLayershell {
    id: launcher

    layer: WlrLayer.Overlay
    implicitWidth: 400
    implicitHeight: 600
    color: "transparent"
    exclusionMode: ExclusionMode.Normal

    anchors {
        bottom: true
    }

    Rectangle {
        id: background

        anchors.topMargin: root.panelHeight
        anchors.fill: parent
        color: colors.surface
        bottomRightRadius: 20
        bottomLeftRadius: 20
        clip: true
    }

}
