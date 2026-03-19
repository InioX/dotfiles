import "../Services"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

RowLayout {
    id: clockRoot

    property bool primaryContainer: true
    property var powerContainerBg: root.powerMenuVisible ? Colors.md3.secondary : (powerMouseArea.containsMouse ? root.secondaryTonalButtonHoverColor : Colors.md3.secondary_container)
    property var powerContainerFg: root.powerMenuVisible ? Colors.md3.on_secondary : Colors.md3.on_secondary_container

    spacing: 3

    Rectangle {
        width: 200
        height: 40
        topLeftRadius: root.cornerRadius
        bottomLeftRadius: root.cornerRadius
        color: searchMouseArea.containsMouse ? root.secondaryTonalButtonHoverColor : Colors.md3.secondary_container

        MouseArea {
            id: searchMouseArea

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }

        RowLayout {
            // ClippingRectangle {
            //     width: 30
            //     height: 30
            //     radius: width / 2
            //     color: "transparent"
            //     Image {
            //         id: profileIcon
            //         source: "file://" + Quickshell.env("HOME") + "/pics/icon.jpg"
            //         anchors.fill: parent
            //         fillMode: Image.PreserveAspectCrop
            //     }
            // }

            anchors.leftMargin: 10
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            Text {
                verticalAlignment: Text.AlignVCenter
                text: "󰍉"
                color: primaryContainer ? Colors.md3.on_secondary_container : Colors.md3.on_surface_variant
                font.pixelSize: 24
                font.bold: true
            }

            Text {
                verticalAlignment: Text.AlignVCenter
                text: "Search..."
                color: primaryContainer ? Colors.md3.on_secondary_container : Colors.md3.on_surface_variant
                font.pixelSize: 14
            }

        }

        RowLayout {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 5

            Text {
                verticalAlignment: Text.AlignVCenter
                text: WeatherService.data.tempFeelsLike
                color: primaryContainer ? Colors.md3.on_secondary_container : Colors.md3.on_surface_variant
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
        color: powerContainerBg

        Text {
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            text: "󰐥 "
            color: powerContainerFg
            font.bold: true
            font.pixelSize: 24
        }

        MouseArea {
            id: powerMouseArea

            anchors.fill: parent
            onClicked: {
                root.powerMenuVisible = !root.powerMenuVisible;
            }
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }

    }

}
