import "../Services"
import QtQuick
import QtQuick.Layouts

Text {
    verticalAlignment: Text.AlignVCenter
    text: TimeService.time
    color: colors.on_surface
    font.bold: true
    font.pixelSize: 14
}
