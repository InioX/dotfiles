import "../Services"
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland

Column {
    id: windowTitle

    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
    property string activeWindowAddress: `0x${activeWindow?.HyprlandToplevel?.address}`

    readonly property string currentTitle: HyprlandService.activeWindow.title || "Desktop"
    readonly property string currentClass: HyprlandService.activeWindow.class || "No programs running"
    
    spacing: 2

    AnimatedTextWidget {
        displayText: windowTitle.currentTitle
        textColor: colors.on_surface
        fontSize: 14
    }

    AnimatedTextWidget {
        displayText: windowTitle.currentClass
        textColor: colors.outline
        fontSize: 11
    }
}
