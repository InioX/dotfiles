import "../Services"
import QtQuick
import Quickshell
import Quickshell.Hyprland

Rectangle {
    color: colors.surface
    height: 35
    width: layout.width + 15
    radius: root.cornerRadius

    Row {
        id: layout

        spacing: 8

        Repeater {
            model: {
                const clients = HyprlandService.allClients;
                const activeWorkspaces = new Set();
                for (let i = 0; i < clients.length; i++) {
                    if (clients[i].workspace && clients[i].workspace.id > 0)
                        activeWorkspaces.add(clients[i].workspace.id);

                }
                return Array.from(activeWorkspaces).sort((a, b) => {
                    return a - b;
                });
            }

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
                height: 30
                radius: 6
                color: isActive ? colors.primary : colors.surface_container_highest

                Row {
                    id: iconsRow

                    spacing: 6
                    anchors.centerIn: parent

                    Repeater {
                        model: clients

                        delegate: Text {
                            font.pixelSize: root.iconSize
                            color: isActive ? colors.on_primary : colors.on_surface_variant
                            text: typeof textIconForClass !== "undefined" ? textIconForClass(modelData.lastIpcObject.class) : "•"
                        }

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
