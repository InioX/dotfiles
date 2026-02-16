import Quickshell.Io


IpcHandler {
    target: "root"

    function toggleLauncher(): void { 
        root.launcherVisible = !root.launcherVisible
        console.log(root.launcherVisible)
    }
}