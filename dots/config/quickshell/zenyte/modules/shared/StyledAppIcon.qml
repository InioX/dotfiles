import QtQuick
import QtQuick.Effects
import Quickshell.Widgets
import Quickshell
import qs.services

Rectangle {
    id: root
    required property string icon
    property int rounding: 30
    property int wantedSize: 40

    property color backgroundColor: Colors.md3.primary_container
    property color iconColor: Colors.md3.on_primary_container

    implicitWidth: imageIcon.width + 10
    implicitHeight: imageIcon.height + 6
    color: Colors.md3.primary_container
    radius: root.rounding

    IconImage {
        id: imageIcon

        anchors.centerIn: parent
        source: Quickshell.iconPath(root.icon, "image-missing")
        implicitSize: root.wantedSize

        layer.enabled: true
        layer.smooth: true

        layer.effect: MultiEffect {
            colorization: 1.0
            colorizationColor: root.iconColor
        }
    }
}
