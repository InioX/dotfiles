import Quickshell
import QtQuick
import QtQuick.Controls
import qs.services

Slider {
    id: slider

    background: Rectangle {
        HoverHandler {
            cursorShape: Qt.PointingHandCursor
        }

        x: slider.leftPadding
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitWidth: parent.width
        implicitHeight: 20
        width: slider.availableWidth
        height: implicitHeight
        radius: 10
        color: Colors.md3.surface_container_high

        Rectangle {
            width: slider.visualPosition * parent.width - 8
            height: parent.height
            color: Colors.md3.primary
            bottomLeftRadius: parent.radius
            topLeftRadius: parent.radius
        }
    }

    handle: Rectangle {
        x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitWidth: 4
        implicitHeight: 30
        radius: 14

        color: Colors.md3.primary
    }
}
