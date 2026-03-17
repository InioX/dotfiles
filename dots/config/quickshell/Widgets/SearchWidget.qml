import "../Services"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

RowLayout {
    id: clockRoot

    property bool primaryContainer: true
    property var primaryContainerFocusedBg: root.powerMenuVisible ? Colors.md3.primary : Colors.md3.primary_container
    property var primaryContainerFocusedFg: root.powerMenuVisible ? Colors.md3.on_primary : Colors.md3.on_primary_container

    spacing: 4

    Rectangle {
        width: 200
        height: 40
        topLeftRadius: root.cornerRadius
        bottomLeftRadius: root.cornerRadius
        color: primaryContainer ? Colors.md3.primary_container : Colors.md3.surface_variant

        RowLayout {
            anchors.leftMargin: 5
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            ClippingRectangle {
                width: 30
                height: 30
                radius: width / 2
                color: "transparent"

                Image {
                    id: profileIcon

                    source: "file://" + Quickshell.env("HOME") + "/pics/icon.jpg"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                }

            }

            Text {
                verticalAlignment: Text.AlignVCenter
                text: "Search..."
                color: primaryContainer ? Colors.md3.on_primary_container : Colors.md3.on_surface_variant
                font.pixelSize: 14
            }

        }

        RowLayout {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 5

            Text {
                verticalAlignment: Text.AlignVCenter
                text: TimeService.time
                color: primaryContainer ? Colors.md3.on_primary_container : Colors.md3.on_surface_variant
                font.bold: true
                font.pixelSize: 14
            }

        }

    }

    Rectangle {
        width: 40
        height: 40
        topRightRadius: root.cornerRadius
        bottomRightRadius: root.cornerRadius
        color: primaryContainer ? primaryContainerFocusedBg : Colors.md3.surface_variant

        Text {
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            text: "󰐥 "
            color: primaryContainer ? primaryContainerFocusedFg : Colors.md3.on_surface_variant
            font.bold: true
            font.pixelSize: 24
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.powerMenuVisible = !root.powerMenuVisible;
            }
        }

    }

}
