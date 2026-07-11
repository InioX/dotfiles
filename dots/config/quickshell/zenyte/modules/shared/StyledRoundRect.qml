import Quickshell
import QtQuick
import qs.services

Rectangle {
    anchors.fill: parent

    radius: Config.bar.popout_radius
    border.width: Config.bar.popout_border ? 1 : 0
    border.color: Colors.md3.outline_variant
    color: Colors.md3.surface
}
