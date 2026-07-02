import qs.services
import QtQuick
import Quickshell.Io

Rectangle {
    id: screenshotRoot
    property var containerBg: mouseArea.containsMouse ? Colors.md3.surface_container_high : Colors.md3.surface_container
    property var containerFg: Colors.md3.on_surface
    color: screenshotRoot.containerBg
    width: 40
    height: 40
    radius: 40

    Text {
        id: text

        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        text: ""
        color: screenshotRoot.containerFg
        font.bold: true
        font.pixelSize: 20
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            screenshotProc.running = true;
            screenshotProc.running = false;
        }

        Process {
            id: screenshotProc
            running: false
            command: ["wf-recorder", "-a"]
        }
    }
}
