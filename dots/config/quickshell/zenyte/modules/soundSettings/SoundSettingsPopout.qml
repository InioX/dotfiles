// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import qs.modules.soundSettings
import Quickshell
import Quickshell.Networking
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
        anchor.gravity: Config.bar.bottom ? (Edges.Top | Edges.Right) : (Edges.Bottom | Edges.Right)

        property int parentX: widgetX - (wantedWidth / 2)
        anchor.window: barWindow

        anchor.rect.x: Math.max(offset, Math.min(parentX, parentWindow.width - width - offset))
        anchor.rect.y: Config.bar.bottom ? (0 - Config.bar.margins.popout) : (parentWindow.height + Config.bar.margins.popout)

        StyledRoundRect {
            id: rect

            opacity: root.isOpen ? 1.0 : 0.9

            Behavior on opacity {
                StyledNumberAnimation {}
            }

            ColumnLayout {
                id: column

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top

                spacing: 20
                anchors.margins: 20

                GridLayout {
                    columns: 2
                    rowSpacing: 10
                    columnSpacing: 10
                    Layout.fillWidth: true

                    QsButton {
                        id: wifiButton

                        name: "Wi-Fi"
                        buttonIcon: "󰖩"

                        Layout.preferredWidth: 1
                        Layout.fillWidth: true
                        enabled: true

                        onClicked: {
                            wifiButton.enabled = !wifiButton.enabled;
                        }
                    }

                    QsButton {
                        id: bluetoothButton

                        name: "Bluetooth"
                        buttonIcon: "󰂯"

                        Layout.preferredWidth: 1
                        Layout.fillWidth: true
                        enabled: false

                        onClicked: {
                            bluetoothButton.enabled = !bluetoothButton.enabled;
                        }
                    }

                    QsButton {
                        id: nightLightButton

                        name: "Night Light"
                        buttonIcon: "󱩌"

                        Layout.preferredWidth: 1
                        Layout.fillWidth: true

                        onClicked: {
                            nightLightButton.enabled = !nightLightButton.enabled;
                        }
                    }

                    QsButton {
                        id: dndButton

                        name: "Do not Disturb"
                        buttonIcon: "󰍶"

                        Layout.preferredWidth: 1
                        Layout.fillWidth: true
                        enabled: false

                        onClicked: {
                            dndButton.enabled = !dndButton.enabled;
                        }
                    }
                }

                StyledSeparator {
                    Layout.fillWidth: true
                }

                RowLayout {
                    spacing: 10

                    StyledText {
                        text: "󰕾"
                        color: Colors.md3.on_surface
                        font.pixelSize: Config.style.font.size.icon_small
                        font.bold: true

                        Layout.preferredWidth: 20
                    }

                    StyledSlider {
                        id: sinkVolumeSlider

                        isActive: !Pipewire.mutedSink

                        Layout.fillWidth: true
                        value: Pipewire.volumeSink / 100

                        onMoved: {
                            Pipewire.setVolumeSink(value);
                        }
                    }
                }

                RowLayout {
                    spacing: 10

                    StyledText {
                        text: "󰍬"
                        color: Colors.md3.on_surface
                        font.pixelSize: Config.style.font.size.icon_small
                        font.bold: true

                        Layout.preferredWidth: 20
                    }

                    StyledSlider {
                        id: sourceVolumeSlider

                        isActive: !Pipewire.mutedSource

                        Layout.fillWidth: true
                        value: Pipewire.volumeSource / 100

                        onMoved: {
                            Pipewire.setVolumeSource(value);
                        }
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
