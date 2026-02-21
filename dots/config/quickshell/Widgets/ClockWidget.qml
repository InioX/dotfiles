import "../Services"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

RowLayout {
    id: clockRoot

    property bool primaryContainer: true
    property var primaryContainerFocusedBg: root.powerMenuVisible ? colors.primary : colors.primary_container
    property var primaryContainerFocusedFg: root.powerMenuVisible ? colors.on_primary : colors.on_primary_container

    spacing: 4

    Rectangle {
        width: 200
        height: 40
        topLeftRadius: root.cornerRadius
        bottomLeftRadius: root.cornerRadius
        color: primaryContainer ? colors.primary_container : colors.surface_variant

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
                color: primaryContainer ? colors.on_primary_container : colors.on_surface_variant
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
                color: primaryContainer ? colors.on_primary_container : colors.on_surface_variant
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
        color: primaryContainer ? primaryContainerFocusedBg : colors.surface_variant

        Text {
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            text: "󰐥 "
            color: primaryContainer ? primaryContainerFocusedFg : colors.on_surface_variant
            font.bold: true
            font.pixelSize: 24
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.powerMenuVisible = !root.powerMenuVisible;
                console.log("Status is now: " + root.powerMenuVisible);
            }
        }

    }

}
