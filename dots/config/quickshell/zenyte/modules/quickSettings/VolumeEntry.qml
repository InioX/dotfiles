import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.shared

Column {
    id: root

    required property string nickname
    required property int volume
    required property bool isMuted

    property string icon: "󰕾"

    signal moved(real value)
    signal muteClicked

    spacing: 20

    RowLayout {
        spacing: 10
        anchors.left: parent.left
        anchors.right: parent.right

        StyledText {

            text: root.icon
            color: Colors.md3.on_surface
            font.pixelSize: Config.style.font.size.big
            font.bold: true
        }

        Rectangle {
            width: nicknameText.width + 20
            height: nicknameText.height + 6
            radius: 10

            color: nicknameMouseArea.containsMouse ? Colors.md3.surface_container_high : Colors.md3.surface

            StyledText {
                id: nicknameText

                anchors.centerIn: parent

                Behavior on color {
                    StyledColorAnimation {}
                }

                StyledMouseArea {
                    id: nicknameMouseArea
                    anchors.fill: parent
                }

                text: root.nickname ? root.nickname : "none"
                color: Colors.md3.on_surface
                font.pixelSize: Config.style.font.size.big
            }
        }

        Item {
            Layout.fillWidth: true
        }

        StyledText {
            Layout.alignment: Qt.AlignRight
            text: (root.volume ? root.volume : 0) + "%"
            color: Colors.md3.on_surface
            font.pixelSize: Config.style.font.size.big
        }

        Rectangle {
            color: Colors.md3.surface_container_high
            width: muteText.width + 20
            height: muteText.height + 6
            radius: 10

            StyledText {
                id: muteText
                text: (root.isMuted ? root.isMuted : false) ? "Unmute" : "Mute"

                color: Colors.md3.on_surface
                font.pixelSize: Config.style.font.size.big
                anchors.centerIn: parent
            }

            StyledMouseArea {
                id: muteMouseArea

                onClicked: {
                    root.muteClicked();
                }
            }
        }
    }

    StyledSlider {
        id: volumeSlider

        width: column.width
        value: root.volume / 100
        onMoved: {
            // For some reason using execDetached is lagging
            // Quickshell.execDetached(['wpctl', 'set-volume', '@DEFAULT_AUDIO_SINK@', value]);
            // Pipewire.setVolume(value);
            root.moved(value);
        }
    }
}
