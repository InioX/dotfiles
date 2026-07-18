// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import qs.modules.soundSettings
import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property bool shouldHighlightBackground: {
        if (soundSettingsMouseArea.containsMouse) {
            return true;
        }
        if (soundPopoutLoader.active) {
            return true;
        }

        return false;
    }

    function open() {
        if (!soundPopoutLoader.active) {
            soundPopoutLoader.active = true;
        } else {
            if (soundPopoutLoader.item) {
                soundPopoutLoader.item.isOpen = false;
            }
        }
    }

    implicitHeight: 40
    implicitWidth: background.width

    StyledMouseArea {
        id: soundSettingsMouseArea

        anchors.fill: parent
        onClicked: {
            root.open();
        }
    }

    Connections {
        target: States
        function onRequestSoundSettingsToggle() {
            delayTimer.running = !delayTimer.running;
        }
    }

    Timer {
        id: delayTimer
        interval: 100
        onTriggered: root.open()
    }

    LazyLoader {
        id: soundPopoutLoader
        active: false
        component: SoundSettingsPopout {
            isOpen: soundPopoutLoader.active
            widgetX: background.mapToItem(null, background.width / 2, 0).x

            onAnimationCloseFinished: {
                States.isSoundSettingsOpened = false;
                soundPopoutLoader.active = false;
            }
        }
    }

    Rectangle {
        id: background

        anchors.fill: parent

        Behavior on color {
            StyledColorAnimation {}
        }

        color: shouldHighlightBackground ? (Config.bar.color_widget_background ? Colors.md3.surface_container_high : Colors.md3.surface_container) : (Config.bar.color_widget_background ? Colors.md3.surface_container : "transparent")
        width: row.width + (!Config.bar.color_widget_background ? 40 : 30)
        radius: Config.style.rounding.small

        border.color: Colors.md3.outline_variant
        border.width: Config.style.borders.widget

        Row {
            id: row
            anchors.centerIn: parent
            spacing: 12

            StyledAnimatedText {
                id: cameraIcon

                displayText: Camera.isShutterClosed ? "󰗟" : "󰄀"
                textColor: Colors.md3.on_surface
                fontSize: Config.style.font.size.icon_small
            }

            StyledAnimatedText {
                id: micIcon

                displayText: Pipewire.mutedSource ? "󰍭" : "󰍬"
                textColor: Colors.md3.on_surface
                fontSize: Config.style.font.size.icon_small
            }

            StyledAnimatedText {
                id: volumeIcon
                displayText: Pipewire.icon
                textColor: Colors.md3.on_surface
                fontSize: Config.style.font.size.icon_small
            }

            Row {
                id: batteryRoot

                anchors.verticalCenter: parent.verticalCenter

                property real batWidth: 30
                property real batHeight: 16
                property real nubWidth: 3
                property real nubHeight: 6
                property real radius: 6

                spacing: 1

                Rectangle {
                    id: track

                    width: batteryRoot.batWidth
                    height: batteryRoot.batHeight
                    radius: batteryRoot.radius
                    color: Battery.colors.bg
                    anchors.verticalCenter: parent.verticalCenter

                    Text {
                        width: track.width
                        height: track.height
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: Math.round(Battery.value * 100)
                        color: Battery.colors.fg
                        font.weight: 800
                        font.pointSize: 8
                    }

                    Item {
                        width: parent.width * Battery.value
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
                            color: Battery.colors.fg

                            Text {
                                id: batteryLabel

                                width: track.width
                                height: track.height
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: Math.round(Battery.value * 100)
                                color: Battery.colors.bg
                                font.weight: 800
                                font.pointSize: 8
                                clip: true
                            }
                        }
                    }
                }

                Rectangle {
                    id: nub

                    width: batteryRoot.nubWidth
                    height: batteryRoot.nubHeight
                    color: Battery.value < 0.99 ? track.color : fill.color
                    topRightRadius: 20
                    bottomRightRadius: 20
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
