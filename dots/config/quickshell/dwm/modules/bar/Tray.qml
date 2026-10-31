import qs.services
import qs.modules.shared
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick

Repeater {
    model: SystemTray.items

    delegate: IconImage {
        id: trayIcon

        source: modelData.icon
        implicitSize: {
            // Discord
            if (modelData.icon === "image://qspixmap/2/1") {
                return 22;
            }

            return Config.style.font.size.small;
        }

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
