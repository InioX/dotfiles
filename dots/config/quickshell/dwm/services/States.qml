pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower

Singleton {
    id: root

    property bool showLauncher: false
    property bool exclusiveFocus: showLauncher

    IpcHandler {
        target: "root"

        function toggleLauncher(): void {
            root.showLauncher = !root.showLauncher;
        }

        function saveConfig(): void {
            Config.saveConfig();
        }
    }
}
