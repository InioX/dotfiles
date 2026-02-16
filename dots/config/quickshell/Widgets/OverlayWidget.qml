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

    LazyLoader {
        active: root.shouldShowOsd
        Component.onCompleted: {
        }

        PanelWindow {
            anchors.bottom: true
            margins.bottom: screen.height / 5
            exclusiveZone: 0
            implicitWidth: 400
            implicitHeight: 50
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: colors.surface_variant

                RowLayout {
                    anchors {
                        fill: parent
                        leftMargin: 10
                        rightMargin: 15
                    }

                    IconImage {
                        implicitSize: 30
                        source: Quickshell.iconPath("audio-volume-high-symbolic")
                    }

                    Rectangle {
                        color: colors.surface_container_highest
                        Layout.fillWidth: true
                        implicitHeight: 10
                        radius: 20

                        Rectangle {
                            implicitWidth: parent.width * (Pipewire.defaultAudioSink.audio.volume ?? 0)
                            radius: parent.radius
                            color: colors.primary

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
