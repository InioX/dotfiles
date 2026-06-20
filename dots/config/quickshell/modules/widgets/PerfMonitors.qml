import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.services

Rectangle {
    id: perfRoot
    width: statRow.width + 40
    height: 40
    radius: root.cornerRadius

    property var containerBg: mouseArea.containsMouse ? Colors.md3.surface_container_high : Colors.md3.surface_container
    property var containerFg: Colors.md3.on_surface
    color: containerBg
    // color: "transparent"

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            Quickshell.execDetached("resources");
        }
    }

    Row {
        id: statRow
        anchors.centerIn: parent
        height: 40

        spacing: 20

        Row {
            anchors.verticalCenter: parent.verticalCenter

            spacing: 10

            Column {
                Text {
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: ""
                    font.pixelSize: 14
                    font.bold: true
                    color: Colors.md3.on_surface
                }

                Text {
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Math.round(UsageService.usedMemoryPerc * 100) + "%"
                    color: Colors.md3.on_surface
                    font.pixelSize: 10
                }
            }

            Rectangle {

                Layout.fillHeight: true
                implicitHeight: parent.height - 5
                width: 5
                radius: 10
                color: Colors.md3.surface_container_highest
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    anchors.bottom: parent.bottom

                    implicitHeight: parent.height * UsageService.usedMemoryPerc
                    width: 5
                    radius: 10
                    color: Colors.md3.primary
                }
            }
        }

        Row {
            anchors.verticalCenter: parent.verticalCenter

            spacing: 10

            Column {
                Text {
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: ""
                    font.pixelSize: 14
                    font.bold: true
                    color: Colors.md3.on_surface
                }

                Text {
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: UsageService.cpuTemp + "°C"
                    color: Colors.md3.on_surface
                    font.pixelSize: 10
                }
            }

            Rectangle {

                Layout.fillHeight: true
                implicitHeight: parent.height - 5
                width: 5
                radius: 10
                color: Colors.md3.surface_container_highest
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    anchors.bottom: parent.bottom

                    implicitHeight: parent.height * (UsageService.cpuTemp / 100)
                    width: 5
                    radius: 10
                    color: Colors.md3.primary
                }
            }
        }

        Row {
            anchors.verticalCenter: parent.verticalCenter

            spacing: 10

            Column {
                Text {
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: ""
                    font.pixelSize: 14
                    font.bold: true
                    color: Colors.md3.on_surface
                }

                Text {
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Math.round(UsageService.cpuPerc * 100) + "%"
                    color: Colors.md3.on_surface
                    font.pixelSize: 10
                }
            }

            Rectangle {

                Layout.fillHeight: true
                implicitHeight: parent.height - 5
                width: 5
                radius: 10
                color: Colors.md3.surface_container_highest
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    anchors.bottom: parent.bottom

                    implicitHeight: parent.height * UsageService.cpuPerc
                    width: 5
                    radius: 10
                    color: Colors.md3.primary
                }
            }
        }
    }
}
