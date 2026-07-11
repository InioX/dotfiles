// qmllint disable unqualified

import "services"
import "modules/bar"
import "modules/desktop"
import "modules/shared"
import QtQuick
import Quickshell
import Quickshell.Io

ShellRoot {
    id: root

    LazyLoader {
        active: true

        component: Bar {}
    }

    WallpaperLayer {
        screen: Quickshell.screens[0]
    }

    Loader {
        active: true

        sourceComponent: RoundBorder {}
    }
}
