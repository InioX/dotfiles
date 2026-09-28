import Quickshell
import QtQuick
import QtQuick.Controls
import qs.services

Slider {
    id: slider

    property var isActive: true

    property color backgroundColor: Colors.md3.surface_container_high
    property color fillColor: isActive ? Colors.md3.primary : Colors.md3.outline

    implicitWidth: vertical ? 16 : 200
    implicitHeight: vertical ? 200 : 16

    background: Rectangle {
        id: bg

        x: slider.vertical ? slider.leftPadding + slider.availableWidth / 2 - width / 2 : slider.leftPadding
        y: slider.vertical ? slider.topPadding : slider.topPadding + slider.availableHeight / 2 - height / 2

        width: slider.vertical ? 16 : slider.availableWidth
        height: slider.vertical ? slider.availableHeight : 16

        radius: 10
        color: slider.backgroundColor

        border.color: Colors.md3.outline_variant
        border.width: Config.style.borders.widget

        StyledHoverHandler {}

        Rectangle {
            id: fill

            x: slider.vertical ? 0 : 2

            y: slider.vertical ? parent.height - height : 0

            width: slider.vertical ? parent.width : slider.visualPosition * parent.width - 4

            height: slider.vertical ? slider.position * parent.height : parent.height

            color: slider.fillColor

            bottomLeftRadius: parent.radius
            topLeftRadius: slider.vertical ? 0 : parent.radius
            bottomRightRadius: slider.vertical ? parent.radius : 0

            Behavior on width {
                enabled: !slider.vertical
                StyledSpringAnimation {}
            }

            Behavior on height {
                enabled: slider.vertical
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
        text: {
            if (slider.to <= 1.0) {
                return (slider.value * 100).toFixed(0) + "%";
            }
            return Math.round(slider.value).toString();
        }

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
        x: slider.vertical ? slider.leftPadding + slider.availableWidth / 2 - width / 2 : slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)

        y: slider.vertical ? slider.topPadding + (1 - slider.position) * (slider.availableHeight - height) : slider.topPadding + slider.availableHeight / 2 - height / 2

        implicitWidth: slider.vertical ? 22 : 4
        implicitHeight: slider.vertical ? 4 : 22
        radius: 14
        color: slider.fillColor
    }
}
