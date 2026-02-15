import "./Services"
import "./Widgets"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Scope {
    id: root

    property int panelHeight: 55
    property int moduleMargin: 10
    property real iconSize: 22.5
    property int cornerRadius: 6
    property var textIconMap: ({
        "floorp": "󰈹",
        "Alacritty": "",
        "kitty": "",
        "code": "󰨞",
        "discord": "",
        "steam": "󰓓",
        "org.pulseaudio.pavucontrol": "󰓃"
    })
    property var distroIcon: ""

    function textIconForClass(cls) {
        return textIconMap[cls] || "";
    }

    Colors {
        id: colors
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            // color: "transparent"
            color: colors.surface
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

                WorkspaceWidget {
                    anchors.centerIn: parent
                }

                RowLayout {
                    spacing: 10
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    BatteryWidget {
                    }

                    ClockWidget {
                    }

                }

            }

        }

    }

}
