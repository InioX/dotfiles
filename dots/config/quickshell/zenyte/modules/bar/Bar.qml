pragma ComponentBehavior: Bound

import qs.services
import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
    id: bar

    Variants {
        // For each monitor
        model: Quickshell.screens
        LazyLoader {
            id: lazyLoader
            required property var modelData

            active: States.showBar
            component: PanelWindow {
                id: barWindow

                MouseArea {
                    id: barMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                }

                aboveWindows: true
                exclusionMode: ExclusionMode.Normal

                screen: modelData
                anchors {
                    top: !Config.bar.bottom
                    bottom: Config.bar.bottom
                    left: true
                    right: true
                }

                implicitHeight: rectangle.implicitHeight
                color: "transparent"

                Rectangle {
                    id: rectangle

                    Behavior on implicitHeight {
                        SpringAnimation {
                            spring: 5
                            damping: 0.7
                        }
                    }

                    implicitHeight: Config.bar.height + (Config.bar.floating ? Config.bar.floating_margins * 2 : 0)
                    radius: Config.bar.floating ? Config.bar.floating_radius : Config.bar.radius
                    color: Colors.md3.surface

                    border.color: Colors.md3.outline_variant
                    border.width: Config.bar.border ? 1 : 0

                    anchors {
                        fill: parent

                        topMargin: Config.bar.floating ? Config.bar.floating_margins : 0
                        bottomMargin: Config.bar.floating ? Config.bar.floating_margins : 0
                        leftMargin: Config.bar.floating ? Config.bar.floating_margins : 0
                        rightMargin: Config.bar.floating ? Config.bar.floating_margins : 0
                    }

                    Item {
                        anchors.fill: parent
                        anchors.leftMargin: 8

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

                            RowLayout {
                                spacing: 3

                                // ClipboardWidget {}

                                // InputMethodWidget {}

                                QuickSettings {}
                            }

                            RowLayout {
                                spacing: 10

                                // SearchWidget {}
                            }
                        }
                    }
                }
            }
        }
    }
}
