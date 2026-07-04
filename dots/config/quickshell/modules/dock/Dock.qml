import qs.services
import qs.modules.widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.LocalStorage
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Io

WlrLayershell {
    id: launcher

    property bool showWorkspaceNumber: false

    layer: WlrLayer.Overlay
    implicitWidth: layout.implicitWidth + 50
    implicitHeight: 100
    color: "transparent"
    exclusionMode: ExclusionMode.Normal

    anchors {
        bottom: true
    }

    Rectangle {
        id: background

        anchors.bottomMargin: 20
        anchors.fill: parent
        color: Colors.md3.surface
        border.color: Colors.md3.outline_variant
        border.width: 1
        radius: 40

        RowLayout {
            // WorkspaceWidget {
            // }
            // Text {
            //     color: Colors.md3.outline_variant
            //     text: "|"
            //     font.pixelSize: 25
            //     verticalAlignment: Text.AlignVCenter
            //     font.bold: true
            // }

            id: layout

            spacing: 10
            anchors.fill: parent
            anchors.leftMargin: 14
            anchors.rightMargin: 14
            anchors.verticalCenter: parent.verticalCenter

            Repeater {
                model: ScriptModel {
                    values: [...NiriService.windows].sort((a, b) => {
                        // First, sort by workspace ID (lowest to highest)
                        if (a.workspaceId !== b.workspaceId) {
                            return a.workspaceId - b.workspaceId;
                        }
                        // If they are on the same workspace, sort by scrolling index
                        return a.scrollingColumnIndex - b.scrollingColumnIndex;
                    })
                }

                delegate: Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 5

                    Rectangle {
                        width: imageIcon.width + 10
                        height: imageIcon.height + 10
                        color: Colors.md3.primary_container
                        radius: 30

                        IconImage {
                            id: imageIcon

                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            // visible: false
                            source: Quickshell.iconPath(AppSearch.guessIcon(modelData.appId), "image-missing")
                            implicitSize: 40
                            layer.enabled: true
                            layer.smooth: true

                            MultiEffect {
                                source: imageIcon
                                anchors.fill: imageIcon
                                colorization: 1
                                colorizationColor: Colors.md3.on_primary_container
                            }

                            MouseArea {
                                id: mouseArea

                                hoverEnabled: true
                                anchors.fill: parent
                                onClicked: {
                                    focusWindowProcess.command.push(modelData.id);
                                    focusWindowProcess.running = true;
                                    focusWindowProcess.command.pop();
                                }

                                ToolTip {
                                    visible: mouseArea.containsMouse
                                    delay: 250

                                    contentItem: Text {
                                        text: modelData.title || "Window"
                                        color: Colors.md3.on_surface
                                        font.pixelSize: 12
                                    }

                                    background: Rectangle {
                                        color: Colors.md3.surface
                                        border.color: Colors.md3.primary
                                        radius: 10
                                    }
                                }
                            }
                        }
                    }

                    Process {
                        id: focusWindowProcess
                        running: false
                        command: ["niri", "msg", "action", "focus-window", "--id"]
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        verticalAlignment: Text.AlignVCenter
                        text: modelData.workspace.name
                        color: Colors.md3.on_surface
                        visible: launcher.showWorkspaceNumber
                        font.pixelSize: 12
                    }
                }
            }

            Text {
                color: Colors.md3.outline_variant
                text: "|"
                font.pixelSize: 25
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                visible: NiriService.windows.length > 0
            }

            Rectangle {
                id: launcherMenu
                property var containerBg: launcherMouseArea.containsMouse ? Colors.md3.surface_container_high : Colors.md3.surface_container
                property var containerFg: Colors.md3.on_surface

                color: launcherMenu.containerBg
                width: launcherIcon.width + 25
                height: launcherIcon.height
                radius: 30

                Text {
                    id: launcherIcon

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    color: launcherMenu.containerFg
                    text: "󰀻"
                    font.pixelSize: 40
                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea {
                    id: launcherMouseArea

                    anchors.fill: parent
                    onClicked: {
                        root.launcherVisible = !root.launcherVisible;
                    }
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
