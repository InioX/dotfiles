import "../Services"
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower

Rectangle {
    id: qsRoot

    property bool hovered: false
    property int fontSize: 14
    property int iconFontSize: 20
    property bool isShutterClosed: false
    property var containerBg: mouseArea.containsMouse ? Colors.md3.surface_container_high : Colors.md3.surface_container
    property var containerFg: Colors.md3.on_surface

    implicitWidth: row.width + 20
    height: 40
    color: containerBg

    Row {
        id: row

        spacing: 5
        anchors.centerIn: parent

        Text {
            id: icon

            verticalAlignment: Text.AlignVCenter
            text: "󰌌"
            color: containerFg
            font.bold: true
            font.pixelSize: root.fontSize
        }

        Text {
            id: label

            verticalAlignment: Text.AlignVCenter
            text: HyprlandInput.currentLayoutName
            color: containerFg
            font.bold: true
            font.pixelSize: root.fontSize
        }

    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: {
            closeAllPopouts("input");
            root.inputMenuVisible = !root.inputMenuVisible;
        }
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }

}
