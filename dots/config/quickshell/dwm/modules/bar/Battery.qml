import qs.services
import qs.modules.shared
import Quickshell
import QtQuick

StyledText {
    text: "󰂀 " + Math.round(Battery.value * 100) + "%"
}
