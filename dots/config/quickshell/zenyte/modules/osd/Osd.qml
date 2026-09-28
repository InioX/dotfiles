import qs.services
import qs.modules.shared

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire as QsPipewire
import Quickshell.Widgets

Scope {
    id: osd

    signal moved(real value)
    signal muteClicked

    required property string icon
    required property int value
    required property bool isActive

    PanelWindow {
        id: osdWindow

        MouseArea {
            id: osdMouseArea
            anchors.fill: parent
            hoverEnabled: true
        }

        // aboveWindows: true
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.namespace: "quickshell-popout"

        screen: Quickshell.screens[0]

        anchors {
            left: true
        }

        implicitWidth: 70
        implicitHeight: 330

        color: "transparent"

        BackgroundEffect.blurRegion: Config.style.blur.popout ? blurRegionDefinition : null

        Region {
            id: blurRegionDefinition
            item: !Compositors.isHyprland ? rect : null
            radius: rect.radius
        }

        StyledRoundRect {
            id: rect

            anchors.fill: parent
            color: Colors.getColorWithAlpha(Colors.md3.surface, (Config.style.blur.popout ? Config.style.transparency.blur_enabled.popout : Config.style.transparency.normal.popout))

            anchors.leftMargin: 8

            ColumnLayout {
                anchors.fill: parent

                anchors.leftMargin: 12
                anchors.rightMargin: 12
                anchors.topMargin: 16
                anchors.bottomMargin: 16

                spacing: 10

                StyledText {
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: osd.value + "%"
                    color: Colors.md3.on_surface
                    font.pixelSize: Config.style.font.size.small
                }

                StyledSlider {
                    id: volumeSlider
                    anchors.horizontalCenter: parent.horizontalCenter

                    orientation: Qt.Vertical

                    isActive: osd.isActive
                    backgroundColor: Colors.getPopoutWidgetColor(Colors.md3.surface_container_high)

                    value: osd.value / 100

                    onMoved: {
                        osd.moved(value);
                    }
                }

                Rectangle {
                    id: background
                    anchors.horizontalCenter: parent.horizontalCenter

                    width: 40
                    height: 40
                    radius: width / 2

                    color: osd.isActive ? Colors.md3.primary_container : Colors.md3.outline

                    Behavior on color {
                        StyledColorAnimation {}
                    }

                    StyledText {
                        anchors.centerIn: parent
                        text: osd.icon

                        color: osd.isActive ? Colors.md3.on_primary_container : Colors.md3.surface_inverse

                        font.bold: true
                        font.pixelSize: Config.style.font.size.icon_medium

                        Behavior on color {
                            StyledColorAnimation {}
                        }
                    }
                }
            }
        }
    }
}
