import qs.services
import qs.modules.shared
import qs.modules.bar
import qs.modules.launcher

import Quickshell
import Quickshell.Services.SystemTray as QsSystemTray
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Scope {
    id: bar

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWindow
            required property var modelData

            WlrLayershell.keyboardFocus: States.exclusiveFocus ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
            WlrLayershell.namespace: "quickshell-bar"

            MouseArea {
                id: barMouseArea
                anchors.fill: parent
                hoverEnabled: true
            }

            // aboveWindows: true
            exclusionMode: ExclusionMode.Auto
            WlrLayershell.layer: WlrLayer.Top

            screen: modelData
            anchors {
                top: !Config.bar.bottom
                bottom: Config.bar.bottom
                left: Config.bar.full_width ? true : false
                right: Config.bar.full_width ? true : false
            }

            visible: rectangle.opacity == 0 ? false : true

            implicitWidth: 1200
            color: "transparent"
            implicitHeight: Config.bar.height + (Config.bar.floating ? Config.bar.margins.floating * 2 : 0)

            Rectangle {
                id: rectangle

                opacity: 1.0

                color: Colors.md3.surface

                anchors {
                    fill: parent
                }

                Item {
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8

                    Loader {
                        anchors.fill: parent
                        active: States.showLauncher
                        sourceComponent: Launcher {}
                    }

                    Loader {
                        anchors.fill: parent
                        active: !States.showLauncher
                        sourceComponent: RowLayout {

                            anchors.fill: parent
                            spacing: 4

                            Workspaces {}

                            Windows {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                            }

                            Separator {
                                symbol: ""
                            }

                            Tray {}

                            Separator {}

                            MicVolume {}

                            Separator {}

                            Volume {}

                            Separator {}

                            Battery {}

                            Separator {}

                            Time {}
                        }
                    }
                }
            }
        }
    }
}
