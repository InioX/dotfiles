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
            implicitWidth: nicknameText.width + 20
            implicitHeight: nicknameText.height + 6
            radius: 10

            color: nicknameMouseArea.containsMouse ? Colors.getPopoutWidgetColor(Colors.md3.surface_container_high) : "transparent"

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
                font.pixelSize: Config.style.font.size.medium
            }
        }

        Item {
            Layout.fillWidth: true
        }

        StyledText {
            Layout.alignment: Qt.AlignRight
            text: (root.volume ? root.volume : 0) + "%"
            color: Colors.md3.on_surface
            font.pixelSize: Config.style.font.size.medium
        }

        Rectangle {
            color: muteMouseArea.containsMouse ? Colors.getPopoutWidgetColor(Colors.md3.surface_container_high) : Colors.getPopoutWidgetColor(Colors.md3.surface_container)
            implicitWidth: muteText.width + 20
            implicitHeight: muteText.height + 6
            radius: 10

            StyledText {
                id: muteText
                text: (root.isMuted ? root.isMuted : false) ? "Unmute" : "Mute"

                color: Colors.md3.on_surface
                font.pixelSize: Config.style.font.size.medium
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

        isActive: !isMuted
        backgroundColor: Colors.getPopoutWidgetColor(Colors.md3.surface_container_high)

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
