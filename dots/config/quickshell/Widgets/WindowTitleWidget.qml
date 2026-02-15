import "../Services"
import QtQuick

Column {
    Text {
        width: Math.min(implicitWidth, 650)
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
        text: HyprlandService.activeWindowName
        color: colors.on_surface
        font.bold: true
    }

    Text {
        width: Math.min(implicitWidth, 650)
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
        text: HyprlandService.activeWindowClass
        color: colors.outline
        font.bold: true
    }

}
