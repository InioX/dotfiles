import "./Services"
import "./Widgets"
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.LocalStorage
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets

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
        color: Colors.md3.surface_container
        border.color: Colors.md3.outline_variant
        border.width: 1
        radius: 20

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
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter

            Repeater {
                model: HyprlandService.windowList.slice().sort((a, b) => {
                    return a.workspace.id - b.workspace.id;
                })

                delegate: Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 5

                    Rectangle {
                        width: imageIcon.width + 10
                        height: imageIcon.height + 10
                        color: Colors.md3.primary_container
                        radius: 20

                        IconImage {
                            id: imageIcon

                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            // visible: false
                            source: Quickshell.iconPath(AppSearch.guessIcon(modelData.class), "image-missing")
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
                                onClicked: Hyprland.dispatch(`workspace ${modelData.workspace.id}`)

                                ToolTip {
                                    visible: mouseArea.containsMouse
                                    delay: 500

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
            }

            Rectangle {
                color: Colors.md3.surface_variant
                width: launcherIcon.width + 25
                height: launcherIcon.height
                radius: 20

                Text {
                    id: launcherIcon

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    color: Colors.md3.on_surface
                    text: "󰀻"
                    font.pixelSize: 40
                    verticalAlignment: Text.AlignVCenter
                }

            }

        }

    }

}
