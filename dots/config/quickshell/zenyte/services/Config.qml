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
    property alias desktop: jsonAdapter.desktop

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
            readonly property Desktop desktop: Desktop {}
        }
    }

    component Bar: JsonObject {
        property JsonObject visible: JsonObject {
            property bool overview: false
            property bool empty_workspace: false
            property bool always: false
            property bool on_top: false
        }

        property JsonObject margins: JsonObject {
            property int popout: 10
            property int floating: 10
        }

        property bool bottom: false
        property int height: 50
        property bool full_width: false
        property bool floating: false
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

        property JsonObject borders: JsonObject {
            property JsonObject bar: JsonObject {
                property int floating: 1
                property int normal: 0
            }
            property int popout: 1
            property int widget: 0
        }

        property JsonObject radius: JsonObject {
            property JsonObject bar: JsonObject {
                property int floating: 30
                property int normal: 0
            }
            property int popout: 30
            property int widget: 20
        }
    }

    component Launcher: JsonObject {
        property list<string> pinned_apps: []
    }

    component Desktop: JsonObject {
        property bool show_icons: true
        property bool show_files: true
        property bool show_folders: true
    }
}
