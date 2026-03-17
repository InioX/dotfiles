import "../Services"
import QtQuick
import Quickshell
import Quickshell.Hyprland

Rectangle {
    color: "transparent"
    width: layout.width + 20
    height: 50
    border.width: root.borderEnabled ? root.borderWidth : 0
    border.color: root.borderColor
    radius: root.cornerRadius

    WheelHandler {
        onWheel: (event) => {
            if (event.angleDelta.y < 0)
                Hyprland.dispatch(`workspace r+1`);
            else if (event.angleDelta.y > 0)
                Hyprland.dispatch(`workspace r-1`);
        }
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    }

    Row {
        id: layout

        anchors.centerIn: parent
        spacing: 8

        Repeater {
            model: 5

            delegate: Rectangle {
                property int wid: index + 1
                property bool isActive: Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === wid
                property var clients: HyprlandService.hyprlandClientsForWorkspace(wid)

                width: Math.max(20, iconsRow.width + (isActive ? 35 : 20))
                height: root.showWorkspaceNumber ? 40 : 35
                radius: 20
                color: isActive ? Colors.md3.secondary_container : Colors.md3.surface_container_highest

                Column {
                    anchors.centerIn: parent
                    spacing: 2

                    Row {
                        id: iconsRow

                        spacing: 6
                        anchors.horizontalCenter: parent.horizontalCenter

                        Text {
                            verticalAlignment: Text.AlignVCenter
                            visible: clients.length === 0
                            text: root.defaultEmptyWorkspaceIcon
                            color: isActive ? Colors.md3.on_secondary_container : Colors.md3.outline_variant
                        }

                        Repeater {
                            model: clients

                            delegate: Text {
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: root.iconSize
                                color: isActive ? Colors.md3.on_secondary_container : Colors.md3.on_surface_variant
                                text: root.textIconForClass(modelData.class)
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
                        color: isActive ? Colors.md3.on_secondary_container : Colors.md3.on_surface_variant
                        verticalAlignment: Text.AlignVCenter
                    }

                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch(`focuswindow address:${modelData.address}`)
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
