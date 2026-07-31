// qmllint disable unqualified

import qs.services
import qs.modules.shared
import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

Item {
    id: root

    property bool shouldHighlightBackground: systemTrayMouseArea.containsMouse

    implicitHeight: 40
    implicitWidth: background.implicitWidth

    StyledMouseArea {
        id: systemTrayMouseArea

        anchors.fill: parent
    }

    Rectangle {
        id: background

        anchors.fill: parent

        Behavior on color {
            StyledColorAnimation {}
        }

        color: shouldHighlightBackground ? (Config.bar.color_widget_background ? Colors.getWidgetColor(Colors.md3.surface_container_high) : Colors.getWidgetColor(Colors.md3.surface_container)) : (Config.bar.color_widget_background ? Colors.getWidgetColor(Colors.md3.surface_container) : "transparent")
        implicitWidth: row.width + (Config.bar.color_widget_background ? 40 : 20)
        radius: Config.style.rounding.small

        border.color: Colors.md3.outline_variant
        border.width: Config.style.borders.widget

        Row {
            id: row
            anchors.centerIn: parent
            spacing: 6

            Repeater {
                model: SystemTray.items

                IconImage {
                    id: trayIcon

                    source: modelData.icon
                    implicitSize: {
                        // Discord
                        if (modelData.icon === "image://qspixmap/2/1") {
                            return 22;
                        }

                        return Config.style.font.size.icon_medium;
                    }

                    anchors.verticalCenter: parent.verticalCenter

                    QsMenuAnchor {
                        id: menuAnchor

                        anchor.window: barWindow
                        menu: modelData.menu
                        anchor.onAnchoring: {
                            const window = barWindow;
                            const widgetRect = window.contentItem.mapFromItem(trayIcon, 0, trayIcon.height + 10, trayIcon.width, trayIcon.height);
                            menuAnchor.anchor.rect = widgetRect;
                        }
                    }

                    StyledMouseArea {
                        id: trayItemMouseArea

                        anchors.fill: parent
                        acceptedButtons: Qt.AllButtons
                        onPressed: event => {
                            menuAnchor.open();
                        }
                    }
                }
            }
        }
    }
}
