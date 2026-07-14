pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Scope {
    id: dock

    Variants {
        // For each monitor
        model: Quickshell.screens

        PanelWindow {
            id: dockWindow
            required property var modelData

            WlrLayershell.keyboardFocus: States.exclusiveFocus ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

            MouseArea {
                id: dockMouseArea
                anchors.fill: parent
                hoverEnabled: true
            }

            // aboveWindows: true
            exclusionMode: (Config.dock.visible.always && !Config.dock.visible.on_top) ? ExclusionMode.Auto : ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Overlay
            screen: modelData
            anchors {
                top: !Config.dock.bottom
                bottom: Config.dock.bottom
                left: Config.dock.full_width ? true : false
                right: Config.dock.full_width ? true : false
            }

            visible: rectangle.opacity == 0 ? false : true

            implicitWidth: 500
            color: "transparent"
            implicitHeight: Config.dock.height + (Config.dock.floating ? Config.dock.margins.floating * 2 : 0)

            Behavior on implicitWidth {
                StyledSpringAnimation {}
            }

            Rectangle {
                id: rectangle

                opacity: States.showDock ? 1.0 : 0.0

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

                radius: Config.dock.floating ? Config.style.radius.dock.floating : Config.style.radius.dock.normal
                color: Colors.md3.surface

                border.color: Colors.md3.outline_variant
                border.width: Config.dock.floating ? Config.style.borders.dock.floating : Config.style.borders.dock.normal

                anchors {
                    fill: parent

                    topMargin: Config.dock.floating ? Config.dock.margins.floating : 0
                    bottomMargin: Config.dock.floating ? Config.dock.margins.floating : 0
                    leftMargin: Config.dock.floating ? Config.dock.margins.floating : 0
                    rightMargin: Config.dock.floating ? Config.dock.margins.floating : 0
                }

                Item {
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8
                }
            }
        }
    }
}
