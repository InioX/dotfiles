import Quickshell
import QtQuick
import QtQuick.Controls
import qs.services

Slider {
    id: slider

    property var isActive: true

    property color backgroundColor: Colors.md3.surface_container_high
    property color fillColor: isActive ? Colors.md3.primary : Colors.md3.outline

    stepSize: 0.01

    background: Rectangle {
        StyledHoverHandler {}

        x: slider.leftPadding
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitHeight: 16
        width: slider.availableWidth
        height: implicitHeight
        radius: 10
        color: slider.backgroundColor

        Rectangle {
            id: fill

            width: slider.visualPosition * parent.width - 4
            height: parent.height
            color: fillColor
            bottomLeftRadius: parent.radius
            topLeftRadius: parent.radius

            Behavior on width {
                StyledSpringAnimation {}
            }

            Behavior on color {
                StyledColorAnimation {}
            }
        }
    }

    ToolTip {
        id: control

        parent: slider.handle
        visible: slider.pressed
        text: (slider.value * 100).toFixed(0)

        contentItem: StyledText {
            text: control.text
            color: Colors.md3.on_surface
            font.pixelSize: Config.style.font.size.small
        }

        background: Rectangle {
            radius: Config.style.radius.widget
            color: Colors.md3.surface
            border.color: Colors.md3.outline_variant
            border.width: Config.style.borders.tooltip
        }
    }

    handle: Rectangle {
        x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
        y: slider.topPadding + slider.availableHeight / 2 - height / 2
        implicitWidth: 4
        implicitHeight: 22
        radius: 14
        color: fillColor

        Behavior on x {
            StyledSpringAnimation {}
        }

        Behavior on y {
            StyledSpringAnimation {}
        }

        Behavior on color {
            StyledColorAnimation {}
        }
    }
}
