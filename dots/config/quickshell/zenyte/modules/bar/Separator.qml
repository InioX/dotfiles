// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property bool circle: true

    implicitHeight: 26
    implicitWidth: 10

    Rectangle {
        visible: !root.circle

        anchors.centerIn: parent

        width: 2
        height: 20
        radius: 40
        color: Colors.md3.outline_variant
    }

    Rectangle {
        visible: root.circle

        anchors.centerIn: parent

        width: 5
        height: 5
        radius: 20
        color: Colors.md3.outline_variant
    }
}
