pragma ComponentBehavior: Bound
import qs.services
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

Rectangle {
    id: workspaceRoot
    required property ShellScreen screen

    property var containerBg: mouseArea.containsMouse ? Colors.md3.surface_container_high : Colors.md3.surface_container
    property var containerFg: Colors.md3.on_surface
    color: workspaceRoot.containerBg
    implicitWidth: wsRow.width + 20
    height: 40
    radius: root.cornerRadius

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

    Row {
        id: wsRow
        spacing: 4
        anchors.centerIn: parent
        Repeater {
            id: wsRepeater
            model: [...NiriService.workspaces.filter(item => item.output === workspaceRoot.screen.name)].sort((a, b) => a.idx - b.idx)
            delegate: Rectangle {
                id: wsDelegate
                required property NiriWorkspace modelData
                property bool highlight: modelData?.isFocused
                // width: wsDelegate.highlight ? 40 : 24
                width: 24
                height: 24
                radius: 30
                color: wsDelegate.highlight ? Colors.md3.primary : "transparent"
                Text {
                    // text: wsDelegate.modelData.idx
                    text: wsDelegate.highlight ? wsDelegate.modelData.idx : "•"
                    color: wsDelegate.highlight ? Colors.md3.on_primary : Colors.md3.outline_variant
                    anchors.centerIn: parent
                    // font.bold: wsDelegate.highlight ? true : false
                    font.bold: true
                    font.pixelSize: 12
                }
            }
        }
    }
}
