import "../Services"
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower

Item {
    id: qsRoot

    property var device: UPower.displayDevice
    property real ratio: device.percentage
    property int percentage: ratio * 100
    property int fontSize: 14
    property int iconFontSize: 20
    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource
    readonly property bool mutedSource: source.audio.muted
    readonly property bool mutedSink: sink.audio.muted
    readonly property int volumeSource: source.audio.volume * 100
    readonly property int volumeSink: sink.audio.volume * 100

    width: layout.width + 20
    height: layout.height + 20

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
                height: batteryRow.height + 15
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
                    height: generalRow.height + 15
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

                    }

                }

            }

            Row {
                spacing: 6

                Rectangle {
                    width: volumeRow.width + 20
                    height: volumeRow.height + 15
                    color: colors.surface_container_highest
                    topRightRadius: root.cornerRadius
                    bottomRightRadius: root.cornerRadius

                    RowLayout {
                        id: volumeRow

                        anchors.centerIn: parent
                        spacing: 6

                        Text {
                            text: mutedSink ? "󰝟" : "󰕾"
                            color: colors.on_surface
                            font.bold: true
                            font.pixelSize: qsRoot.iconFontSize
                        }

                        Text {
                            text: qsRoot.volumeSink + "%"
                            color: colors.on_surface
                            font.bold: true
                            font.pixelSize: qsRoot.fontSize
                        }

                    }

                }

            }

        }

    }

}
