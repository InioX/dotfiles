import QtQuick
import Quickshell
import Quickshell.Services.UPower

Rectangle {
    id: batteryRoot

    property var device: UPower.displayDevice
    property real ratio: device.percentage
    property int percentage: ratio * 100
    property int fontSize: 12

    width: textContainer.width + 30
    height: 17
    radius: 8
    color: colors.primary_container
    clip: true

    Item {
        id: textContainer

        anchors.fill: parent

        Row {
            anchors.centerIn: parent
            spacing: 6

            Text {
                text: percentage + "%"
                font.pixelSize: batteryRoot.fontSize
                font.bold: true
                color: colors.on_primary_container
            }

        }

    }

    Rectangle {
        id: fillBar

        height: parent.height
        width: parent.width * batteryRoot.ratio
        color: colors.primary
        radius: parent.radius
        clip: true

        Item {
            width: batteryRoot.width
            height: batteryRoot.height

            Row {
                anchors.centerIn: parent
                spacing: 6

                Text {
                    text: percentage + "%"
                    font.pixelSize: batteryRoot.fontSize
                    font.bold: true
                    color: colors.on_primary
                }

            }

        }

        Behavior on width {
            NumberAnimation {
                duration: 400
                easing.type: Easing.OutCubic
            }

        }

    }

}
