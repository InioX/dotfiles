// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import Quickshell
import QtQuick

PopupWindow {
    id: root
    property bool isOpen: false
    property int offset: Config.bar.floating_margins ? Config.bar.floating_margins : 0
    property int parentX: parentWindow.width / 2 - width / 2

    property int wantedWidth: 500
    property int wantedHeight: 400

    anchor.window: barWindow
    anchor.rect.x: Math.max(offset, Math.min(parentX, parentWindow.width - width - offset))
    anchor.rect.y: Config.bar.bottom ? 0 : parentWindow.height
    anchor.gravity: Config.bar.bottom ? (Edges.Top | Edges.Right) : (Edges.Bottom | Edges.Right)

    implicitWidth: wantedWidth
    implicitHeight: isOpen ? wantedHeight : 1
    visible: true
    color: "transparent"

    Behavior on implicitHeight {
        SpringAnimation {
            spring: 5
            damping: 0.4
        }
    }
}
