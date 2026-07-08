pragma Singleton
pragma ComponentBehavior: Bound
import qs.services
import qs.services.niri
import QtQuick
import Quickshell

Singleton {
    id: root

    property bool showBar: {
        if (Config.bar.show_in_overview && Niri.isOverview) {
            return true;
        }

        if (Config.bar.show_on_empty_workspace && !Niri.focusedWindow) {
            return true;
        }

        return Config.bar.show_on_top;
    }
}
