//@ pragma UseQApplication
// qmllint disable unqualified

import "services"
import "modules/shared"
import "modules/bar"
import "modules/dock"
import "modules/desktop"
import "modules/settings"
import QtQuick
import Quickshell

ShellRoot {
    id: root

    Loader {
        active: true

        sourceComponent: Bar {}
    }

    Loader {
        active: true

        sourceComponent: Dock {}
    }

    Loader {
        active: States.isSettingsOpened

        sourceComponent: Settings {}
    }

    WallpaperLayer {
        screen: Quickshell.screens[0]
    }

    Loader {
        active: !Config.bar.floating

        sourceComponent: RoundBorder {}
    }
}
