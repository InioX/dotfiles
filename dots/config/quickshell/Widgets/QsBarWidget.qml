import "../Services"
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower

Item {
    id: qsRoot

    property bool hovered: false
    property int fontSize: 14
    property int iconFontSize: 20
    property bool isShutterClosed: false
    property var containerBg: mouseArea.containsMouse ? Colors.md3.surface_container_high : Colors.md3.surface_container
    property var containerFg: Colors.md3.on_surface

    implicitWidth: container.width
    height: 40

    Process {
        id: camCheck

        running: true
        command: ["v4l2-ctl", "-d", "/dev/video0", "--get-ctrl=privacy"]

        stdout: StdioCollector {
            onStreamFinished: {
                const text = String(data).trim();
                isShutterClosed = text.includes("privacy: 1");
            }
        }

    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            camCheck.running = false;
            camCheck.running = true;
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: {
            root.qsMenuVisible = !root.qsMenuVisible;
        }
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }

    Row {
        id: layout

        anchors.centerIn: parent

        Item {
            id: container

            width: qsRow.width + 25
            height: 40

            Rectangle {
                id: qsRect

                anchors.fill: parent
                color: containerBg
                topRightRadius: 60
                bottomRightRadius: 60
            }

            RowLayout {
                id: qsRow

                anchors.centerIn: parent
                spacing: 10

                Row {
                    id: root

                    property real batWidth: 30
                    property real batHeight: 16
                    property real nubWidth: 3
                    property real nubHeight: 6
                    property real radius: 6

                    spacing: 1

                    Rectangle {
                        id: track

                        width: root.batWidth
                        height: root.batHeight
                        radius: root.radius
                        color: BatteryService.colors.bg
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            width: track.width
                            height: track.height
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: Math.round(BatteryService.value * 100)
                            color: BatteryService.colors.fg
                            font.weight: 800
                            font.pointSize: 8
                        }

                        Item {
                            width: parent.width * BatteryService.value
                            clip: true

                            anchors {
                                top: parent.top
                                bottom: parent.bottom
                                left: parent.left
                            }

                            Rectangle {
                                id: fill

                                width: track.width
                                height: track.height
                                radius: track.radius
                                color: BatteryService.colors.fg

                                Text {
                                    id: batteryLabel

                                    width: track.width
                                    height: track.height
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    text: Math.round(BatteryService.value * 100)
                                    color: BatteryService.colors.bg
                                    font.weight: 800
                                    font.pointSize: 8
                                    clip: true
                                }

                            }

                        }

                    }

                    Rectangle {
                        id: nub

                        width: root.nubWidth
                        height: root.nubHeight
                        color: BatteryService.value < 0.99 ? track.color : fill.color
                        topRightRadius: 20
                        bottomRightRadius: 20
                        anchors.verticalCenter: parent.verticalCenter
                    }

                }

                RowLayout {
                    Text {
                        text: PipewireService.mutedSource ? "󰍭" : "󰍬"
                        color: containerFg
                        font.bold: true
                        font.pixelSize: qsRoot.iconFontSize
                    }

                    Text {
                        text: isShutterClosed ? "󰗟" : "󰄀"
                        color: containerFg
                        font.bold: true
                        font.pixelSize: qsRoot.iconFontSize
                    }

                }

                RowLayout {
                    Text {
                        text: PipewireService.icon
                        color: containerFg
                        font.bold: true
                        font.pixelSize: qsRoot.iconFontSize
                    }

                }

            }

        }

    }

}
