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

        path: Quickshell.env("HOME") + "/.config/quickshell/zenyte/config.json"
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
        property bool bottom: false
        property int height: 50
        property bool border: false
        property bool full_width: false
        property bool border_widgets: false
        property bool floating: false
        property int floating_margins: 10
        property int radius: 0
        property int floating_radius: 0
        property int widget_radius: 20
        property bool show_in_overview: true
        property bool show_on_empty_workspace: true
        property bool show_on_top: false
    }

    component Style: JsonObject {
        property JsonObject font: JsonObject {
            property JsonObject size: JsonObject {
                property int small: 14
                property int medium: 16
                property int big: 18
                property int icon: 34
                property int icon_small: 22
                property int icon_medium: 26
            }
        }
        property JsonObject rounding: JsonObject {
            property int small: 20
        }
    }

    component Launcher: JsonObject {
        property list<string> pinned_apps: []
    }
}
