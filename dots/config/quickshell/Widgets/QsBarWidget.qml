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

    property int fontSize: 14
    property int iconFontSize: 20
    property bool isShutterClosed: false

    width: 210
    height: layout.height + 20

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
        anchors.fill: parent
        onClicked: {
            root.qsMenuVisible = !root.qsMenuVisible;
        }
    }

    Row {
        id: layout

        anchors.centerIn: parent

        Item {
            // RectangularShadow {
            //     id: shadow
            //     anchors.fill: qsRect
            //     height: qsRect.height
            //     radius: qsRect.radius
            //     blur: 40
            //     spread: 0
            //     color: colors.shadow
            // }

            id: container

            width: qsRow.width + 30 - 1
            height: qsRow.height + 20 - 1

            Rectangle {
                // border.width: root.borderEnabled ? root.borderWidth : 0
                // border.color: root.borderColor

                id: qsRect

                border.color: colors.outline_variant
                border.width: 1
                anchors.fill: parent
                color: colors.surface_container_high
                radius: 60
            }

            RowLayout {
                id: qsRow

                anchors.centerIn: parent
                spacing: 10

                RowLayout {
                    Text {
                        text: "󰁿"
                        color: colors.on_surface
                        font.bold: true
                        font.pixelSize: qsRoot.iconFontSize
                    }

                    Text {
                        text: BatteryService.percentage + "%"
                        color: colors.on_surface
                        font.bold: true
                        font.pixelSize: qsRoot.fontSize
                    }

                }

                RowLayout {
                    Text {
                        text: PipewireService.mutedSource ? "󰍭" : "󰍬"
                        color: colors.on_surface
                        font.bold: true
                        font.pixelSize: qsRoot.iconFontSize
                    }

                    Text {
                        text: isShutterClosed ? "󰗟" : "󰄀"
                        color: colors.on_surface
                        font.bold: true
                        font.pixelSize: qsRoot.iconFontSize
                    }

                }

                RowLayout {
                    Text {
                        text: PipewireService.mutedSink ? "󰝟" : "󰕾"
                        color: colors.on_surface
                        font.bold: true
                        font.pixelSize: qsRoot.iconFontSize
                    }

                    Text {
                        text: PipewireService.volumeSink + "%"
                        color: colors.on_surface
                        font.bold: true
                        font.pixelSize: qsRoot.fontSize
                    }

                }

            }

        }

    }

}
