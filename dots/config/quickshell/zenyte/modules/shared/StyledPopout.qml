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

    property int wantedWidth: 500
    property int wantedHeight: 400

    anchor.window: barWindow
    // anchor.rect.x: parentWindow.width / 2 - width / 2
    anchor.rect.x: (parentWindow.width - width) - 20
    anchor.rect.y: parentWindow.height
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
