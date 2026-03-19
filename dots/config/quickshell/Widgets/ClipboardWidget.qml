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

    width: 40
    height: 40
    topLeftRadius: root.cornerRadius
    bottomLeftRadius: root.cornerRadius
    color: containerBg

    Text {
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        text: "󰅌"
        color: containerFg
        font.bold: true
        font.pixelSize: 24
    }

    MouseArea {
        id: powerMouseArea

        anchors.fill: parent
        onClicked: {
            root.powerMenuVisible = !root.powerMenuVisible;
        }
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: {
            closeAllPopouts("clipboard");
            root.clipboardMenuVisible = !root.clipboardMenuVisible;
        }
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }

}
