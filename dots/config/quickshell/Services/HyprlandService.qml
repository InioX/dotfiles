import QtQuick
import Quickshell
import Quickshell.Hyprland
pragma Singleton

Singleton {
    id: root

    property var allClients: Hyprland.toplevels.values
    property var activeWindowName: Hyprland.activeToplevel.title || "Desktop"
    property var activeWindowClass: Hyprland.activeToplevel.lastIpcObject.class || "No programs running"

    Connections {
        // enabled: initialized

        function onRawEvent(event) {
            Hyprland.refreshWorkspaces();
            Hyprland.refreshToplevels();
            allClients = Hyprland.toplevels.values;
        }

        target: Hyprland
    }

}
