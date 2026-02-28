import "./Services"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
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
        color: colors.surface
        radius: 20
        clip: true

        RowLayout {
            id: layout

            spacing: 10
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10

            Repeater {
                model: HyprlandService.windowList.slice().sort((a, b) => {
                    return a.workspace.id - b.workspace.id;
                })

                delegate: Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 5

                    IconImage {
                        source: Quickshell.iconPath(AppSearch.guessIcon(modelData.class), "image-missing")
                        implicitSize: 40

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
                                    color: colors.on_surface
                                    font.pixelSize: 12
                                }

                                background: Rectangle {
                                    color: colors.surface
                                    border.color: colors.primary
                                    radius: 10
                                }

                            }

                        }

                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        verticalAlignment: Text.AlignVCenter
                        text: modelData.workspace.name
                        color: colors.on_surface
                        visible: launcher.showWorkspaceNumber
                        font.pixelSize: 12
                    }

                }

            }

        }

    }

}
