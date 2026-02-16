import "./Services"
import "./Widgets"
import QtQuick
import QtQuick.Layouts
import Quickshell

ShellRoot {
    id: root

    property bool shouldShowOsd: false
    property bool launcherVisible: false

    Colors {
        id: colors
    }

    IpcHandlers {
    }

    Loader {
        active: root.launcherVisible

        sourceComponent: AppLauncher {
        }

    }

    Loader {

        sourceComponent: OverlayWidget {
        }

    }

    Bar {
    }

}
