import "../Services"
import QtQuick
import Quickshell
import Quickshell.Hyprland

Rectangle {
    color: colors.surface_container
    height: layout.height + root.showWorkspaceNumber ? 40 : 20
    width: layout.width + 15
    radius: root.cornerRadius

    Row {
        id: layout

        anchors.centerIn: parent
        spacing: 8

        Repeater {
            model: 5

            delegate: Rectangle {
                property int wid: index + 1
                property var clients: {
                    const out = [];
                    const all = HyprlandService.allClients;
                    for (let i = 0; i < all.length; i++) {
                        if (all[i].workspace && all[i].workspace.id === wid)
                            out.push(all[i]);

                    }
                    return out;
                }
                property bool isActive: Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === wid

                width: Math.max(20, iconsRow.width + (isActive ? 30 : 16))
                height: root.showWorkspaceNumber ? 40 : 30
                radius: 20
                color: isActive ? colors.primary : colors.surface_container_highest

                Column {
                    anchors.centerIn: parent
                    spacing: 2

                    Row {
                        id: iconsRow

                        spacing: 6
                        anchors.horizontalCenter: parent.horizontalCenter

                        Text {
                            visible: clients.length === 0
                            text: root.defaultEmptyWorkspaceIcon
                            color: colors.outline_variant
                        }

                        Repeater {
                            model: clients

                            delegate: Text {
                                font.pixelSize: root.iconSize
                                color: isActive ? colors.on_primary : colors.on_surface_variant
                                text: textIconForClass(modelData.lastIpcObject.class)
                                font.bold: isActive ? true : false
                            }

                        }

                    }

                    Text {
                        visible: root.showWorkspaceNumber
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: wid
                        font.pixelSize: 12
                        font.bold: isActive ? true : false
                        color: isActive ? colors.on_primary : colors.on_surface_variant
                    }

                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch(`workspace ${wid}`)
                }

                Behavior on width {
                    NumberAnimation {
                        duration: 450
                        easing.type: Easing.OutExpo
                    }

                }

                Behavior on color {
                    ColorAnimation {
                        duration: 250
                        easing.type: Easing.InOutQuad
                    }

                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutBack
                    }

                }

            }

        }

    }

}
