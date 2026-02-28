import "./Services"
import "./Widgets"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Scope {
    id: barRoot

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWindow

            required property var modelData

            // color: "transparent"
            color: colors.surface_dim
            screen: modelData
            implicitHeight: root.panelHeight

            anchors {
                top: true
                left: true
                right: true
                bottom: false
            }

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

                    spacing: 0
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    QsBarWidget {
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
