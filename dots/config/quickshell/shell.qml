import "./Services"
import "./Widgets"
import QtQuick
import QtQuick.Layouts
import Quickshell

ShellRoot {
    id: root

    property int panelHeight: 70
    property int moduleMargin: 10
    property real iconSize: 22.5
    property int cornerRadius: 16
    property var textIconMap: ({
        "floorp": "󰈹",
        "Alacritty": "",
        "kitty": "",
        "code": "󰨞",
        "discord": "",
        "steam": "󰓓",
        "net.lutris.Lutris": "󰒓",
        "steam_app_default": "󰊗",
        "org.pulseaudio.pavucontrol": "󰓃"
    })
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
    property bool borderEnabled: false
    property int borderWidth: 1
    property var borderColor: colors.outline_variant

    function textIconForClass(cls) {
        return textIconMap[cls] || "";
    }

    Colors {
        id: colors
    }

    IpcHandlers {
    }

    Loader {
        active: root.qsMenuVisible

        sourceComponent: QsPopout {
        }

    }

    Loader {
        active: root.launcherVisible

        sourceComponent: AppLauncher {
        }

    }

    Loader {
        active: root.dockVisible

        sourceComponent: Dock {
        }

    }

    Loader {

        sourceComponent: OverlayWidget {
        }

    }

    Bar {
    }

    RoundBorder {
    }

}
