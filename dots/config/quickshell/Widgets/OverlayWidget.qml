import "../Services"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
    id: osdRoot

    Connections {
        function onVolumeChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
        }

        target: Pipewire.defaultAudioSink.audio
    }

    Timer {
        id: hideTimer

        interval: 1000
        onTriggered: root.shouldShowOsd = false
    }

    Loader {
        active: root.shouldShowOsd

        sourceComponent: PanelWindow {
            anchors.bottom: true
            margins.bottom: screen.height / 8
            implicitWidth: 400
            implicitHeight: 50
            color: "transparent"
            exclusionMode: ExclusionMode.Normal

            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: Colors.md3.surface_container

                RowLayout {
                    spacing: 10

                    anchors {
                        fill: parent
                        leftMargin: 20
                        rightMargin: 20
                    }

                    Text {
                        font.pixelSize: 30
                        text: "󰕾"
                        color: Colors.md3.on_surface
                    }

                    Rectangle {
                        color: Colors.md3.surface_container_highest
                        Layout.fillWidth: true
                        implicitHeight: 10
                        radius: 20

                        Rectangle {
                            implicitWidth: parent.width * (Pipewire.defaultAudioSink.audio.volume ?? 0)
                            radius: parent.radius
                            color: Colors.md3.primary

                            anchors {
                                left: parent.left
                                top: parent.top
                                bottom: parent.bottom
                            }

                        }

                    }

                }

            }

            mask: Region {
            }

        }

    }

}
