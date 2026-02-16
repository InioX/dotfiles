import "./Services"
import "./Widgets"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

ShellRoot {
    id: root

    property bool shouldShowOsd: false
    property bool launcherVisible: false

    Colors {
        id: colors
    }
    
    IpcHandler {
        target: "root"

        function toggleLauncher(): void { 
            root.launcherVisible = !root.launcherVisible
            console.log(root.launcherVisible)
        }
    }

    Loader {
        active: launcherVisible

        sourceComponent: AppLauncher {
        }

    }

    Loader {

        sourceComponent: OverlayWidget {
        }

    }

    Loader {

        sourceComponent: Bar {
        }

    }

}
