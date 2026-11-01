import qs.services
import qs.modules.shared
import Quickshell
import QtQuick

StyledText {
    readonly property string icon: Pipewire.mutedSource ? "󰍭 " : "󰍬 "

    text: icon + Pipewire.volumeSource + "%"
}
