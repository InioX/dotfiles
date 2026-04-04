import "./Services"
import "./Widgets"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Scope {
    id: barRoot

    property int topMargin: 10

    Variants {
        model: Quickshell.screens

        WlrLayershell {
            id: barWindow

            required property var modelData

            // color: "transparent"
            screen: modelData
            layer: WlrLayer.Overlay
            implicitHeight: root.panelHeight + topMargin
            exclusionMode: ExclusionMode.Normal
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
                bottom: false
            }

            Rectangle {
                anchors.topMargin: topMargin
                anchors.leftMargin: topMargin
                anchors.rightMargin: topMargin
                radius: 30
                border.color: Colors.md3.outline_variant
                border.width: 1
                implicitHeight: root.panelHeight
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

                        DistroWidget {
                        }

                        WindowTitleWidget {
                        }

                    }

                    RowLayout {
                        anchors.centerIn: parent
                        anchors.verticalCenter: parent.verticalCenter

                        ClockWidget {
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

                            ClipboardWidget {
                            }

                            InputMethodWidget {
                            }

                            QsBarWidget {
                            }

                        }

                        RowLayout {
                            spacing: 10

                            SearchWidget {
                            }

                        }

                    }

                }

            }

        }

    }

}
