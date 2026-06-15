//@ pragma UseQApplication
import "services"
import "modules/appLauncher"
import "modules/bar"
import "modules/overlayWidget"
import "modules/dock"
import "modules/clipboard"
import "modules/inputMethod"
import "modules/quickSettings"
import "modules/widgets"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

ShellRoot {
    // RoundBorder {
    // }

    id: root

    property int panelHeight: 66
    property int moduleMargin: 10
    property real iconSize: 22.5
    property int cornerRadius: 16
    property var distroIcon: ""
    property bool showWorkspaceNumber: false
    property var defaultEmptyWorkspaceIcon: ""
    property bool shouldShowOsd: false
    property bool launcherVisible: false
    property bool powerMenuVisible: false
    property bool dockVisible: false
    property bool dockOpenedManually: false
    property bool launcherOpenedOnce: false
    property bool qsMenuVisible: false
    property bool clipboardMenuVisible: false
    property bool inputMenuVisible: false
    property bool borderEnabled: false
    property int borderWidth: 1
    property var borderColor: Colors.md3.outline_variant
    property var secondaryTonalButtonHoverColor: Colors.palette.secondary40
    property var primaryTonalButtonHoverColor: Colors.palette.primary40

    function closeAllPopouts(current) {
        if (current != "qs")
            root.qsMenuVisible = false;

        if (current != "clipboard")
            root.clipboardMenuVisible = false;

        if (current != "input")
            root.inputMenuVisible = false;

    }

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

        if (!root.dockVisible) {
            closeAllPopouts("");
        }

        // if (!root.launcherVisible) {
            // dockOpenedManually = !root.dockOpenedManually
        // }
    }

    function showDock(): void {
        root.dockVisible = true

        if (!root.dockVisible) {
            closeAllPopouts("");
        }
    }

    function hideDock(): void {
        root.dockVisible = false
        closeAllPopouts("");
    }
}
}

    Loader {
        active: root.qsMenuVisible

        sourceComponent: QsPopout {
        }

    }

    Loader {
        active: root.clipboardMenuVisible

        sourceComponent: ClipboardPopout {
        }

    }

    Loader {
        active: root.inputMenuVisible

        sourceComponent: InputMethodPopout {
        }

    }

    Loader {
        active: root.launcherVisible

        sourceComponent: AppLauncher {
        }

    }

    Loader {
        active: root.dockVisible || HyprlandService.shouldShowWorkspaceOverlay

        sourceComponent: Dock {
        }

    }

    Loader {

        sourceComponent: OverlayWidget {
        }

    }

    Loader {
        // active: root.dockVisible || HyprlandService.shouldShowWorkspaceOverlay
        active: root.dockVisible

        sourceComponent: Bar {
        }

    }

}
