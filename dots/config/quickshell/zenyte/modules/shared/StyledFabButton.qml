import Quickshell
import QtQuick
import qs.services
import qs.modules.shared

Rectangle {
    id: root

    implicitWidth: 60
    implicitHeight: 60

    property alias buttonText: innerText.text
    property alias buttonIcon: innerText.text

    property color normalColor: Colors.md3.surface_container
    property color highlightColor: Colors.md3.surface_container_high

    property color normalTextColor: Colors.md3.on_surface
    property color highlightTextColor: Colors.md3.on_surface

    signal clicked

    color: mouseArea.containsMouse ? root.highlightColor : root.normalColor
    radius: 20

    Behavior on color {
        StyledColorAnimation {}
    }

    StyledText {
        id: innerText

        text: buttonText

        Behavior on color {
            StyledColorAnimation {}
        }

        anchors.centerIn: parent
        color: mouseArea.containsMouse ? root.highlightTextColor : root.normalTextColor
        font.pixelSize: Config.style.font.size.icon_medium
    }

    StyledMouseArea {
        id: mouseArea

        anchors.fill: parent

        onClicked: {
            root.clicked();
        }
    }
}
