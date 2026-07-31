import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.modules.shared

TextField {
    id: root

    property color backgroundColor: Colors.md3.surface_container
    property color activeBackgroundColor: Colors.md3.surface_container_high

    color: Colors.md3.on_surface
    placeholderTextColor: Colors.getColorWithAlpha(Colors.md3.on_surface, 0.5)
    selectedTextColor: Colors.md3.on_primary
    selectionColor: Colors.md3.primary

    implicitWidth: 160
    implicitHeight: 40

    leftPadding: 12
    rightPadding: 12
    topPadding: 8
    bottomPadding: 8

    verticalAlignment: TextInput.AlignVCenter
    font.pixelSize: 14

    background: Rectangle {
        id: bgRect
        radius: Config.style.radius.widget

        color: {
            if (root.activeFocus)
                return root.activeBackgroundColor;
            return root.backgroundColor;
        }

        border.color: root.activeFocus ? Colors.md3.primary : "transparent"
        border.width: root.activeFocus ? 1.5 : 0

        Behavior on color {
            StyledColorAnimation {}
        }
        Behavior on border.color {
            StyledColorAnimation {}
        }
    }
}
