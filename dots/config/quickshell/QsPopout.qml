import "./Services"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import QtQuick.Shapes
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets

WlrLayershell {
    // function getMaxBrightness() {
    //     const cmd = "brightnessctl max";
    //     getMaxBrightnessProcess.command = ["/bin/sh", "-c", cmd];
    //     getMaxBrightnessProcess.running = true;
    // }

    id: qsPopout

    function setVolume(value) {
        const cmd = "wpctl set-volume @DEFAULT_AUDIO_SINK@ " + value * 100 + "%";
        setVolumeProcess.command = ["/bin/sh", "-c", cmd];
        setVolumeProcess.running = true;
    }

    layer: WlrLayer.Overlay
    implicitWidth: 500
    implicitHeight: 320
    color: "transparent"
    exclusionMode: ExclusionMode.Normal
    margins.top: screen.height / 12
    margins.right: 10

    Process {
        id: setVolumeProcess

        running: false
    }

    anchors {
        top: true
        right: true
    }

    Rectangle {
        id: background

        anchors.fill: parent
        color: Colors.md3.surface
        radius: 30
        border.color: Colors.md3.outline_variant
        border.width: 1

        ColumnLayout {
            id: layout

            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 20
            spacing: 0

            ColumnLayout {
                spacing: 20

                RowLayout {
                    spacing: 20

                    Text {
                        text: "Hello, ini"
                        color: Colors.md3.on_surface
                        font.bold: true
                        font.pixelSize: 20
                    }

                }

                RowLayout {
                    spacing: 20

                    Text {
                        text: "󰕾"
                        color: Colors.md3.on_surface
                        font.bold: true
                        font.pixelSize: 25
                    }

                    Slider {
                        id: volumeControl

                        Layout.fillWidth: true
                        value: PipewireService.volumeSink / 100
                        onMoved: setVolume(value)

                        background: Rectangle {
                            x: volumeControl.leftPadding
                            y: volumeControl.topPadding + volumeControl.availableHeight / 2 - height / 2
                            implicitWidth: 200
                            implicitHeight: 14
                            width: volumeControl.availableWidth
                            height: implicitHeight
                            radius: 10
                            color: Colors.md3.surface_container

                            Rectangle {
                                width: volumeControl.visualPosition * parent.width
                                height: parent.height
                                color: Colors.md3.primary
                                radius: 10
                            }

                        }

                        handle: Rectangle {
                            x: volumeControl.leftPadding + volumeControl.visualPosition * (volumeControl.availableWidth - width)
                            y: volumeControl.topPadding + volumeControl.availableHeight / 2 - height / 2
                            implicitWidth: 26
                            implicitHeight: 26
                            radius: 13
                            // color: volumeControl.pressed ? "#f0f0f0" : "#f6f6f6"
                            // border.color: "#bdbebf"
                            color: "transparent"
                        }

                    }

                }

                RowLayout {
                    spacing: 20

                    Text {
                        text: "󰃠"
                        color: Colors.md3.on_surface
                        font.bold: true
                        font.pixelSize: 25
                    }

                    Slider {
                        // onMoved: setVolume(value)

                        id: brightnessControl

                        Layout.fillWidth: true
                        value: 100

                        background: Rectangle {
                            x: brightnessControl.leftPadding
                            y: brightnessControl.topPadding + brightnessControl.availableHeight / 2 - height / 2
                            implicitWidth: 200
                            implicitHeight: 14
                            width: brightnessControl.availableWidth
                            height: implicitHeight
                            radius: 10
                            color: Colors.md3.surface_container

                            Rectangle {
                                width: brightnessControl.visualPosition * parent.width
                                height: parent.height
                                color: Colors.md3.primary
                                radius: 10
                            }

                        }

                        handle: Rectangle {
                            x: brightnessControl.leftPadding + brightnessControl.visualPosition * (brightnessControl.availableWidth - width)
                            y: brightnessControl.topPadding + brightnessControl.availableHeight / 2 - height / 2
                            implicitWidth: 26
                            implicitHeight: 26
                            radius: 13
                            // color: brightnessControl.pressed ? "#f0f0f0" : "#f6f6f6"
                            // border.color: "#bdbebf"
                            color: "transparent"
                        }

                    }

                }

            }

            ColumnLayout {
                spacing: 20

                RowLayout {
                    spacing: 20

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 220
                        height: 50
                        color: Colors.md3.primary
                        radius: 10

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "HIIIIIII"
                            color: Colors.md3.on_primary
                        }

                    }

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 220
                        height: 50
                        color: Colors.md3.primary
                        radius: 10

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "HIIIIIII"
                            color: Colors.md3.on_primary
                        }

                    }

                }

                RowLayout {
                    spacing: 20

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 220
                        height: 50
                        color: Colors.md3.primary
                        radius: 10

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "HIIIIIII"
                            color: Colors.md3.on_primary
                        }

                    }

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 220
                        height: 50
                        color: Colors.md3.primary
                        radius: 10

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "HIIIIIII"
                            color: Colors.md3.on_primary
                        }

                    }

                }

            }

        }

    }

}
