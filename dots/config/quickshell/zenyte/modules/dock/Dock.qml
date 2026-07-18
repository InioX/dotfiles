import qs.services
import qs.services.niri
import qs.modules.shared
import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Scope {
    id: dock

    PanelWindow {
        id: dockWindow

        MouseArea {
            id: dockMouseArea
            anchors.fill: parent
            hoverEnabled: true
        }

        // aboveWindows: true
        exclusionMode: (Config.dock.visible.always && !Config.dock.visible.on_top) ? ExclusionMode.Auto : ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.namespace: "quickshell-dock"

        screen: Quickshell.screens[0]
        anchors {
            top: !Config.dock.bottom
            bottom: Config.dock.bottom
            left: Config.dock.full_width ? true : false
            right: Config.dock.full_width ? true : false
        }

        visible: rectangle.opacity == 0 ? false : true

        implicitWidth: rectangle.implicitWidth
        color: "transparent"
        implicitHeight: Config.dock.height + (Config.dock.floating ? Config.dock.margins.floating * 2 : 0)

        BackgroundEffect.blurRegion: Config.style.blur.dock ? blurRegionDefinition : null

        Region {
            id: blurRegionDefinition
            item: rectangle
            radius: rectangle.radius
        }

        Rectangle {
            id: rectangle

            implicitWidth: 50 + rowLayout.implicitWidth

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
            color: Colors.getColorWithAlpha(Colors.md3.surface, (Config.style.blur.dock ? Config.style.transparency.blur_enabled.dock : Config.style.transparency.normal.dock))

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
                id: dockWrapper

                anchors.fill: parent
                anchors.leftMargin: 8
                anchors.rightMargin: 8
                anchors.topMargin: 10

                RowLayout {
                    id: rowLayout
                    anchors.centerIn: parent
                    spacing: 16

                    anchors.margins: 20

                    Repeater {
                        model: DockApps.items

                        delegate: ColumnLayout {
                            id: delegateRoot
                            required property var modelData
                            required property int index

                            Layout.alignment: Qt.AlignVCenter
                            spacing: 8

                            MouseArea {
                                id: dockIconMouseArea

                                Layout.preferredWidth: Config.dock.icons.size
                                Layout.preferredHeight: Config.dock.icons.size
                                Layout.alignment: Qt.AlignHCenter

                                cursorShape: Qt.PointingHandCursor

                                StyledAppIcon {
                                    anchors.centerIn: parent

                                    backgroundColor: Colors.md3.primary

                                    icon: modelData.icon
                                    wantedSize: Config.dock.icons.size
                                }

                                onClicked: {
                                    if (modelData.isRunning && modelData.window) {
                                        Quickshell.execDetached(["niri", "msg", "action", "focus-window", "--id", modelData.window.id]);
                                    } else {
                                        Quickshell.execDetached(["sh", "-c", "setsid -f " + modelData.command]);
                                    }
                                }
                            }

                            Rectangle {
                                Layout.preferredWidth: 5
                                Layout.preferredHeight: 5
                                radius: 2
                                color: modelData.isRunning ? Colors.md3.primary : "transparent"

                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }
                }
            }
        }
    }
}
