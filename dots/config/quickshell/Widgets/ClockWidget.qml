import "../Services"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

RowLayout {
    id: clockRoot

    property bool primaryContainer: true

    spacing: 3

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
        width: 30
        height: 40
        topRightRadius: root.cornerRadius
        bottomRightRadius: root.cornerRadius
        color: primaryContainer ? colors.primary_container : colors.surface_variant
        anchors.verticalCenter: parent.verticalCenter

        Text {
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            text: " "
            color: primaryContainer ? colors.on_primary_container : colors.on_surface_variant
            font.bold: true
            font.pixelSize: 20
        }

    }

}
