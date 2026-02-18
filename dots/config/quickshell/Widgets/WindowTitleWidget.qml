import "../Services"
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland

Column {
    id: windowTitle
    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

    property string activeWindowAddress: `0x${activeWindow?.HyprlandToplevel?.address}`

    Text {
        width: Math.min(implicitWidth, 650)
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
        text: HyprlandService.activeWindow.title
        color: colors.on_surface
        font.bold: true
    }

    Text {
        width: Math.min(implicitWidth, 650)
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
        text: HyprlandService.activeWindow.class
        color: colors.outline
        font.bold: true
    }

}
