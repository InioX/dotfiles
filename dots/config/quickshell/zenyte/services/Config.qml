pragma Singleton
pragma ComponentBehavior: Bound
import qs.services
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias bar: jsonAdapter.bar
    property alias style: jsonAdapter.style

    FileView {
        path: Quickshell.env("HOME") + "/.config/quickshell/zenyte/config.json"
        watchChanges: true
        onFileChanged: reload()

        JsonAdapter {
            id: jsonAdapter

            readonly property Bar bar: Bar {}
            readonly property Style style: Style {}
        }
    }

    component Bar: JsonObject {
        property bool bottom: false
        property int height: 50
        property int clock_margin: 8
    }

    component Style: JsonObject {
        property JsonObject font: JsonObject {
            property int size_small: 14
            property int size_big: 20
        }
    }
}
