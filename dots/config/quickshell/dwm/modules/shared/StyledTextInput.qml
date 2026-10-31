import qs.modules.shared
import qs.services
import QtQuick

TextInput {
    color: Colors.md3.on_surface

    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
    font.family: Config.style.font.name
    font.pixelSize: Config.style.font.size.small
}
