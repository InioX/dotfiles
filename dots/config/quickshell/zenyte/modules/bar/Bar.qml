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
            required property var modelData

            active: States.showBar
            component: PanelWindow {

                screen: modelData
                anchors {
                    top: !Config.bar.bottom
                    bottom: Config.bar.bottom
                    left: true
                    right: true
                }

                color: "transparent"

                implicitHeight: Config.bar.height

                Rectangle {
                    anchors.fill: parent
                    color: Colors.md3.surface

                    Item {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10

                        RowLayout {
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 10

                            // DistroWidget {}

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

                            ClockWidget {
                                Layout.alignment: Qt.AlignVCenter
                            }
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

                                // QsBarWidget {}
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
