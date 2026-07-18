pragma Singleton
pragma ComponentBehavior: Bound
import qs.services
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property alias bar: jsonAdapter.bar
    property alias dock: jsonAdapter.dock
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
            readonly property Dock dock: Dock {}
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
        property bool color_widget_background: true
    }

    component Dock: JsonObject {
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

        property JsonObject icons: JsonObject {
            property int size: 40
            property bool colorize: true
        }

        property bool bottom: true
        property int height: 50
        property bool full_width: false
        property bool floating: false
    }

    component Style: JsonObject {
        property JsonObject font: JsonObject {
            property JsonObject size: JsonObject {
                property int small: 14
                property int medium: 16
                property int big: 20
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
            property JsonObject dock: JsonObject {
                property int floating: 1
                property int normal: 0
            }
            property int popout: 1
            property int widget: 0
            property int tooltip: 0
        }

        property JsonObject radius: JsonObject {
            property JsonObject bar: JsonObject {
                property int floating: 30
                property int normal: 0
            }
            property JsonObject dock: JsonObject {
                property int floating: 30
                property int normal: 0
            }
            property int popout: 30
            property int widget: 20
            property int qs_button: 20
        }

        property JsonObject blur: JsonObject {
            property bool bar: true
            property bool widget: true
            property bool dock: true
            property bool popout: true
        }

        property JsonObject transparency: JsonObject {
            property JsonObject normal: JsonObject {
                property real bar: 1
                property real dock: 1
                property real popout: 1
            }

            property JsonObject blur_enabled: JsonObject {
                property real bar: 0.7
                property real widget: 0.9
                property real dock: 0.7
                property real popout: 0.7
                property real popout_widget: 0.9
            }
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
