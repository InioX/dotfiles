pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Scope {
    id: bar

    Variants {
        // For each monitor
        model: Quickshell.screens

        PanelWindow {
            id: barWindow
            required property var modelData

            WlrLayershell.keyboardFocus: States.exclusiveFocus ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

            MouseArea {
                id: barMouseArea
                anchors.fill: parent
                hoverEnabled: true
            }

            // aboveWindows: true
            exclusionMode: ExclusionMode.Auto
            WlrLayershell.layer: WlrLayer.Overlay
            screen: modelData
            anchors {
                top: !Config.bar.bottom
                bottom: Config.bar.bottom
                left: Config.bar.full_width ? true : false
                right: Config.bar.full_width ? true : false
            }

            visible: rectangle.opacity == 0 ? false : true

            implicitHeight: rectangle.implicitHeight
            implicitWidth: 1200
            color: "transparent"

            Behavior on implicitWidth {
                StyledSpringAnimation {}
            }

            Behavior on anchors {
                StyledSpringAnimation {}
            }

            Rectangle {
                id: rectangle

                opacity: States.showBar ? 1.0 : 0.0

                Behavior on opacity {
                    StyledNumberAnimation {}
                }

                Behavior on implicitHeight {
                    StyledSpringAnimation {}
                }

                Behavior on x {
                    StyledSpringAnimation {}
                }

                Behavior on y {
                    StyledSpringAnimation {}
                }

                implicitHeight: Config.bar.height + (Config.bar.floating ? Config.bar.margins.floating * 2 : 0)
                radius: Config.bar.floating ? Config.style.radius.bar.floating : Config.style.radius.bar.normal
                color: Colors.md3.surface

                border.color: Colors.md3.outline_variant
                border.width: Config.bar.floating ? Config.style.borders.bar.floating : Config.style.borders.bar.normal

                anchors {
                    fill: parent

                    topMargin: Config.bar.floating ? Config.bar.margins.floating : 0
                    bottomMargin: Config.bar.floating ? Config.bar.margins.floating : 0
                    leftMargin: Config.bar.floating ? Config.bar.margins.floating : 0
                    rightMargin: Config.bar.floating ? Config.bar.margins.floating : 0
                }

                Item {
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8

                    RowLayout {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 10

                        DistroWidget {}

                        ClockWidget {
                            alignCenter: false
                        }

                        // NiriWorkspaceWidget {
                        // screen: barWindow.modelData
                        // }

                        // PerfMonitors {}

                        // ScreenshotWidget {}

                        // RecordingWidget {}

                        // WindowTitleWidget {}
                    }

                    RowLayout {
                        anchors.centerIn: parent
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    RowLayout {
                        // BatteryWidget {
                        // }

                        spacing: 10
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter

                        RecordingWidget {}

                        QuickSettings {}
                    }
                }
            }
        }
    }
}
