// qmllint disable unqualified

import "services"
import "modules/bar"
import "modules/shared"
import "modules/desktop"
import "modules/settings"
import QtQuick
import Quickshell
import Quickshell.Io

ShellRoot {
    id: root

    LazyLoader {
        active: true

        component: Bar {}
    }

    LazyLoader {
        active: States.isSettingsOpened

        component: Settings {}
    }

    WallpaperLayer {
        screen: Quickshell.screens[0]
    }

    Loader {
        active: true

        sourceComponent: RoundBorder {}
    }
}
