import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire
import qs.services

ColumnLayout {
    id: column
    required property PwNode node

    Layout.fillWidth: true
    // bind the node so we can read its properties
    PwObjectTracker {
        objects: [node]
    }

    Text {
        text: column.node.name
        color: "white"
    }

    RowLayout {
        Image {
            visible: source != ""
            source: {
                const icon = node.properties["application.icon-name"] ?? "audio-volume-high-symbolic";
                return `image://icon/${icon}`;
            }

            sourceSize.width: 20
            sourceSize.height: 20
        }

        // Label {
        //     text: {
        //         // application.name -> description -> name
        //         const app = node.properties["application.name"] ?? (node.description != "" ? node.description : node.name);
        //         const media = node.properties["media.name"];
        //         return media != undefined ? `${app} - ${media}` : app;
        //     }
        // }

        Button {
            text: node.audio.muted ? "unmute" : "mute"
            onClicked: node.audio.muted = !node.audio.muted
        }
    }

    RowLayout {
        Label {
            Layout.preferredWidth: 50
            text: `${Math.floor(node.audio.volume * 100)}%`
        }

        Slider {
            id: volumeControl

            Layout.fillWidth: true
            value: node.audio.volume
            onValueChanged: node.audio.volume = value

            background: Rectangle {
                x: volumeControl.leftPadding
                y: volumeControl.topPadding + volumeControl.availableHeight / 2 - height / 2
                implicitWidth: 200
                implicitHeight: 14
                width: volumeControl.availableWidth
                height: implicitHeight
                radius: 10
                color: Colors.md3.surface_container

                Rectangle {
                    width: volumeControl.visualPosition * parent.width
                    height: parent.height
                    color: Colors.md3.primary
                    radius: 10
                }
            }

            handle: Rectangle {
                x: volumeControl.leftPadding + volumeControl.visualPosition * (volumeControl.availableWidth - width)
                y: volumeControl.topPadding + volumeControl.availableHeight / 2 - height / 2
                implicitWidth: 26
                implicitHeight: 26
                radius: 13
                // color: volumeControl.pressed ? "#f0f0f0" : "#f6f6f6"
                // border.color: "#bdbebf"
                color: "transparent"
            }
        }
    }
}
