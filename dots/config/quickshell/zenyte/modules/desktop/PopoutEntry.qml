import Quickshell
import QtQuick
import qs.modules.shared
import qs.services

Rectangle {
    id: root
    signal clicked

    implicitHeight: 40

    color: mouseArea.containsMouse ? Colors.md3.surface_container : Colors.md3.surface
    radius: Config.style.radius.widget

    StyledMouseArea {
        id: mouseArea

        onClicked: {
            root.clicked();
        }
    }

    Behavior on color {
        StyledColorAnimation {}
    }
}
