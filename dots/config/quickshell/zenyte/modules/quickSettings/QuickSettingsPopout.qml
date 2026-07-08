// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import Quickshell
import Quickshell.Services.Pipewire as QsPipewire
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    property bool isOpen: false
    required property int widgetX

    signal animationCloseFinished

    Timer {
        id: destroyTimer
        interval: 150
        onTriggered: root.animationCloseFinished()
    }

    onIsOpenChanged: {
        if (!isOpen) {
            destroyTimer.start();
        } else {
            destroyTimer.stop();
        }
    }

    StyledPopout {
        isOpen: root.isOpen

        wantedHeight: column.implicitHeight + 60
        wantedWidth: 500

        parentX: widgetX - (wantedWidth / 2)

        StyledRoundRect {
            id: rect

            ColumnLayout {
                id: column

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top

                spacing: 20
                anchors.margins: 20

                VolumeEntry {
                    nickname: Pipewire.sink.nickname
                    volume: Pipewire.volumeSink
                    isMuted: Pipewire.mutedSink

                    onMoved: {
                        Pipewire.setVolumeSink(value);
                    }

                    onMuteClicked: {
                        Quickshell.execDetached(['wpctl', 'set-mute', '@DEFAULT_AUDIO_SINK@', 'toggle']);
                    }
                }

                VolumeEntry {
                    nickname: Pipewire.source.nickname
                    volume: Pipewire.volumeSource
                    isMuted: Pipewire.mutedSource
                    icon: "󰍬"

                    onMoved: {
                        Pipewire.setVolumeSource(value);
                    }

                    onMuteClicked: {
                        Quickshell.execDetached(['wpctl', 'set-mute', '@DEFAULT_AUDIO_SOURCE@', 'toggle']);
                    }
                }

                StyledSeparator {
                    visible: Pipewire.streamNodes?.length >= 1
                    Layout.fillWidth: true
                }

                Repeater {
                    id: appRepeater
                    visible: Pipewire.streamNodes?.length >= 1

                    model: Pipewire.streamNodes

                    delegate: VolumeEntry {
                        required property QsPipewire.PwNode modelData

                        QsPipewire.PwObjectTracker {
                            objects: [modelData]
                        }

                        nickname: modelData.properties["application.name"]
                        volume: modelData.audio?.volume * 100
                        isMuted: modelData.audio?.muted

                        onMoved: {
                            modelData.audio.volume = value;
                        }

                        onMuteClicked: {
                            modelData.audio.muted = !modelData.audio.muted;
                        }
                    }
                }
            }
        }
    }
}
