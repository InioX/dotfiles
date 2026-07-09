import Quickshell
import QtQuick
import QtQuick.Controls
import qs.services

Slider {
    id: slider

    property var isActive: true

    property var fillColor: isActive ? Colors.md3.primary : Colors.md3.outline

    background: Rectangle {
        HoverHandler {
            cursorShape: Qt.PointingHandCursor
        }

        x: slider.leftPadding
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitWidth: parent.width
        implicitHeight: 14
        width: slider.availableWidth
        height: implicitHeight
        radius: 10
        color: Colors.md3.surface_container_high

        Rectangle {
            id: fill

            width: slider.visualPosition * parent.width - 8
            height: parent.height
            color: fillColor
            bottomLeftRadius: parent.radius
            topLeftRadius: parent.radius

            Behavior on width {
                SpringAnimation {
                    spring: 5
                    damping: 0.7
                }
            }

            Behavior on color {
                StyledColorAnimation {}
            }
        }
    }

    handle: Rectangle {
        x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitWidth: 4
        implicitHeight: 30
        radius: 14
        color: fillColor

        Behavior on x {
            SpringAnimation {
                spring: 5
                damping: 0.7
            }
        }

        Behavior on y {
            SpringAnimation {
                spring: 5
                damping: 0.7
            }
        }

        Behavior on color {
            StyledColorAnimation {}
        }
    }
}
