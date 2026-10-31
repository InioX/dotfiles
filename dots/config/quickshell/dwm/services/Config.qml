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
    property alias launcher: jsonAdapter.launcher

    function saveConfig() {
        configFile.writeAdapter();
    }

    FileView {
        id: configFile

        path: Quickshell.env("HOME") + "/.config/quickshell/dwm/config.json"
        watchChanges: true
        onFileChanged: reload()

        blockLoading: true

        JsonAdapter {
            id: jsonAdapter

            readonly property Bar bar: Bar {}
            readonly property Style style: Style {}
            readonly property Launcher launcher: Launcher {}
        }
    }

    component Bar: JsonObject {
        property JsonObject margins: JsonObject {
            property int popout: 10
            property int floating: 10
        }

        property bool bottom: false
        property int height: 22
        property bool full_width: true
        property bool floating: false
        property bool color_widget_background: true
    }

    component Style: JsonObject {
        property JsonObject font: JsonObject {
            property string name: "Terminess Nerd Font Mono"
            property JsonObject size: JsonObject {
                property int small: 20
            }
        }
    }

    component Launcher: JsonObject {
        property list<string> pinned_apps: []
        property list<string> editor_command: ["zeditor", "%path"]
    }
}
