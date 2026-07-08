import Quickshell
import QtQuick
import qs.services

Rectangle {
    anchors.fill: parent

    radius: Config.bar.floating ? Config.bar.floating_radius : Config.bar.radius
    border.width: Config.bar.border ? 1 : 0
    border.color: Colors.md3.outline_variant
    color: Colors.md3.surface
}
