import Quickshell.Io
import Quickshell
import QtQuick

Item {
    Timer {
        id: launcherDelayTimer
        interval: 100
        repeat: false
        onTriggered: {
            root.launcherVisible = !root.launcherVisible
        }
    }

    IpcHandler {
    target: "root"

    function toggleLauncher(): void {
        root.launcherVisible = !root.launcherVisible
        // launcherDelayTimer.running = true

        // if (!root.dockOpenedManually && root.launcherOpenedOnce) {
            // root.dockVisible = false
        // }

        // root.launcherOpenedOnce =! root.launcherOpenedOnce
    }

    function toggleDock(): void {
        root.dockVisible = !root.dockVisible
        // if (!root.launcherVisible) {
            // dockOpenedManually = !root.dockOpenedManually
        // }
    }

    
}
}
