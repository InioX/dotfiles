import Quickshell
import QtQuick
import QtQuick.Controls
import qs.services

CheckBox {
    id: control
    checked: Config.desktop.show_icons
    implicitWidth: 40
    implicitHeight: 40
    spacing: 16

    indicator: Item {
        implicitWidth: 40
        implicitHeight: 40

        x: 0
        y: parent.height / 2 - height / 2

        Rectangle {
            id: stateLayer
            anchors.centerIn: parent
            width: 40
            height: 40
            radius: 20

            color: control.pressed ? (control.checked ? Colors.md3.primary : Colors.md3.on_surface) : (control.hovered ? (control.checked ? Colors.md3.primary : Colors.md3.on_surface) : "transparent")
            opacity: control.pressed ? 0.12 : (control.hovered ? 0.08 : 0.0)

            Behavior on opacity {
                NumberAnimation {
                    duration: 100
                }
            }
        }

        Rectangle {
            id: checkboxBase
            anchors.centerIn: parent
            width: 20
            height: 20
            radius: 2

            color: control.checked ? Colors.md3.primary : "transparent"
            border.color: control.checked ? Colors.md3.primary : Colors.md3.outline
            border.width: control.checked ? 0 : 2

            Behavior on color {
                StyledColorAnimation {}
            }
            Behavior on border.color {
                StyledColorAnimation {}
            }

            HoverHandler {
                cursorShape: Qt.PointingHandCursor
            }

            Item {
                width: parent.width
                height: parent.height
                visible: control.checked

                Rectangle {
                    id: checkStemShort
                    x: 5
                    y: 10
                    width: 2
                    height: 4
                    color: Colors.md3.on_primary
                    rotation: -45
                    transformOrigin: Item.TopLeft
                }
                Rectangle {
                    id: checkStemLong
                    x: 8
                    y: 13
                    width: 7
                    height: 2
                    color: Colors.md3.on_primary
                    rotation: -45
                    transformOrigin: Item.TopLeft
                }
            }
        }
    }

    contentItem: StyledText {
        text: control.text
        color: control.enabled ? Colors.md3.on_surface : Colors.md3.outline
        font.pixelSize: Config.style.font.size.small

        leftPadding: control.indicator.width + control.spacing
    }
}
