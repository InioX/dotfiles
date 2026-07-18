import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services

ListView {
    id: root

    property color highlightColor: Colors.md3.surface_container

    property int entryRadius: 24

    Layout.fillWidth: true
    Layout.maximumHeight: 500
    Layout.preferredHeight: root.contentHeight

    highlight: Rectangle {
        color: root.highlightColor
        radius: root.entryRadius
    }
    highlightMoveDuration: 80
}
