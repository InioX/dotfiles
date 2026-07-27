// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import Quickshell
import Quickshell.Wayland
import QtQuick

PopupWindow {
    id: root
    property bool isOpen: false
    property int offset: Config.bar.margins.floating ? Config.bar.margins.floating : 0

    property int wantedWidth: 500
    property int wantedHeight: 400

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
