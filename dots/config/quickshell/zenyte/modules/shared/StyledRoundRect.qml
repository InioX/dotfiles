import Quickshell
import QtQuick
import qs.services

Rectangle {
    anchors.fill: parent

    radius: Config.style.radius.popout
    border.width: Config.style.borders.popout
    border.color: Colors.md3.outline_variant
    color: Colors.md3.surface
}
