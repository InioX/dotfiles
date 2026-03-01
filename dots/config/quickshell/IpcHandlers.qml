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
        root.dockVisible = true
        launcherDelayTimer.running = true

        if (!root.dockOpenedManually && root.launcherOpenedOnce) {
            root.dockVisible = false
        }

        root.launcherOpenedOnce =! root.launcherOpenedOnce
    }

    function toggleDock(): void {
        if (!root.launcherVisible) {
            dockOpenedManually = !root.dockOpenedManually
            root.dockVisible = !root.dockVisible
        }
    }

    
}
}
