import qs.modules.shared
import qs.services
import QtQuick

Text {
    id: root

    color: Colors.md3.on_surface
    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
    font.family: Config.style.font.name
    font.pixelSize: Config.style.font.size.small
}
