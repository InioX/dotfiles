import Quickshell
import QtQuick
import QtQuick.Controls
import qs.services
import qs.modules.shared

Switch {
    id: control

    property color activeTrackColor: Colors.md3.primary
    property color activeThumbColor: Colors.md3.on_primary
    property color inactiveTrackColor: Colors.md3.surface_container_highest
    property color inactiveThumbColor: Colors.md3.outline
    property color activeOutlineColor: "transparent"
    property color inactiveOutlineColor: Colors.md3.outline

    implicitWidth: 52
    implicitHeight: 32

    padding: 0
    leftPadding: 0
    rightPadding: 0
    topPadding: 0
    bottomPadding: 0

    StyledHoverHandler {}

    background: Rectangle {
        id: backgroundContainer

        implicitWidth: control.implicitWidth
        implicitHeight: control.implicitHeight
        radius: height / 2

        color: control.checked ? control.activeTrackColor : control.inactiveTrackColor

        border.color: control.checked ? control.activeOutlineColor : control.inactiveOutlineColor
        border.width: control.checked ? 0 : 2

        Behavior on color {
            StyledColorAnimation {}
        }
        Behavior on border.color {
            StyledColorAnimation {}
        }
    }

    indicator: Rectangle {
        id: thumb

        width: control.down ? 28 : (control.checked ? 24 : 16)
        height: width
        radius: width / 2

        y: (control.height - height) / 2

        x: control.checked ? (control.width - width - 4) : (backgroundContainer.border.width + 6)

        color: control.checked ? control.activeThumbColor : control.inactiveThumbColor

        Behavior on x {
            StyledSpringAnimation {}
        }
        Behavior on width {
            NumberAnimation {
                duration: 100
                easing.type: Easing.OutQuad
            }
        }
        Behavior on color {
            StyledColorAnimation {}
        }
    }
}
