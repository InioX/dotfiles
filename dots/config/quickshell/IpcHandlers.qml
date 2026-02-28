import Quickshell.Io


IpcHandler {
    target: "root"

    function toggleLauncher(): void { 
        root.launcherVisible = !root.launcherVisible
    }

    function toggleDock(): void { 
        root.dockVisible = !root.dockVisible
    }
}