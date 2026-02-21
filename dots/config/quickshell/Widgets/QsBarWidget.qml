import "../Services"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower

Item {
    id: qsRoot

    property var device: UPower.displayDevice
    property real ratio: device ? device.percentage : 0
    property int percentage: Math.round(ratio * 100)
    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource
    readonly property bool mutedSource: source.audio.muted ?? true
    readonly property bool mutedSink: sink.audio.muted ?? true
    readonly property int volumeSource: source.audio ? (source.audio.volume * 100) : 0
    readonly property int volumeSink: sink.audio ? (sink.audio.volume * 100) : 0
    property int fontSize: 14
    property int iconFontSize: 20
    property bool isShutterClosed: false

    width: 230
    height: layout.height + 20

    Process {
        id: networkMonitor

        running: true
        command: ["nmcli", "monitor"]
    }

    Connections {
        // connected / disconnected

        function onRead(data) {
            const text = String(data).trim();
            console.log("nmcli:", text);
            if (text.startsWith("STATE"))
                networkState = text.split(/\s+/)[1];
            else if (text.startsWith("DEVICE"))
                activeDevice = text.split(/\s+/)[1]; // e.g., wlan0
        }

        target: networkMonitor.stdout
    }

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

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    Row {
        id: layout

        anchors.centerIn: parent

        Row {
            spacing: 3

            Rectangle {
                width: batteryRow.width + 20
                height: batteryRow.height + 20
                color: colors.surface_container_highest
                topLeftRadius: root.cornerRadius
                bottomLeftRadius: root.cornerRadius

                RowLayout {
                    id: batteryRow

                    anchors.centerIn: parent
                    spacing: 6

                    Text {
                        text: "󰁿"
                        color: colors.on_surface
                        font.bold: true
                        font.pixelSize: qsRoot.iconFontSize
                    }

                    Text {
                        text: percentage + "%"
                        color: colors.on_surface
                        font.bold: true
                        font.pixelSize: qsRoot.fontSize
                    }

                }

            }

            Row {
                spacing: 6

                Rectangle {
                    width: generalRow.width + 20
                    height: generalRow.height + 20
                    color: colors.surface_container_highest

                    RowLayout {
                        id: generalRow

                        anchors.centerIn: parent
                        spacing: 6

                        Text {
                            text: mutedSource ? "󰍭" : "󰍬"
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

                }

            }

            Row {
                spacing: 6

                Rectangle {
                    id: volumeContainer

                    width: volumeRow.width + 20
                    height: volumeRow.height + 20
                    color: colors.surface_container_highest
                    topRightRadius: root.cornerRadius
                    bottomRightRadius: root.cornerRadius

                    RowLayout {
                        // Text {
                        //     text: qsRoot.volumeSink + "%"
                        //     color: colors.on_surface
                        //     font.bold: true
                        //     font.pixelSize: qsRoot.fontSize
                        // }

                        id: volumeRow

                        anchors.centerIn: parent
                        spacing: 6

                        Text {
                            text: mutedSink ? "󰝟" : "󰕾"
                            color: colors.on_surface
                            font.bold: true
                            font.pixelSize: qsRoot.iconFontSize
                        }

                        AnimatedTextWidget {
                            displayText: qsRoot.volumeSink + "%"
                            textColor: colors.on_surface
                            fontSize: qsRoot.fontSize
                            isBold: true
                        }

                    }

                }

            }

        }

    }

}
