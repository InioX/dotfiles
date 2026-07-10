import qs.services
import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    id: root
    property int iconPadding: 14
    property bool searchTextEntered: (search.text.length > 0)
    property int searchRadius: 30

    property alias text: search.text

    color: Colors.md3.surface_container
    radius: root.searchRadius
    Layout.preferredHeight: 50
    Layout.preferredWidth: root.searchTextEntered ? parent.width : parent.width - 20
    Layout.alignment: Qt.AlignHCenter

    z: 2

    Behavior on Layout.preferredWidth {
        StyledSpringAnimation {}
    }

    RowLayout {
        id: searchRow
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 10
        Layout.fillWidth: true
        Layout.preferredHeight: parent.Layout.preferredHeight

        StyledText {
            leftPadding: root.iconPadding
            text: root.searchTextEntered ? "" : ""
            color: Colors.md3.on_surface
            font.pixelSize: Config.style.font.size.icon_small
        }

        TextField {
            id: search

            Layout.preferredHeight: parent.Layout.preferredHeight

            placeholderText: "Type to search"
            placeholderTextColor: Colors.md3.on_surface
            color: Colors.md3.on_surface

            font.pixelSize: Config.style.font.size.small

            enabled: true
            focus: true
            activeFocusOnPress: true

            background: Rectangle {
                color: "transparent"
            }
        }

        Item {
            Layout.fillWidth: true
        }

        StyledText {
            rightPadding: root.iconPadding
            text: root.searchTextEntered ? "" : "󰍬"
            color: Colors.md3.on_surface
            font.pixelSize: Config.style.font.size.icon_small
        }
    }
}
