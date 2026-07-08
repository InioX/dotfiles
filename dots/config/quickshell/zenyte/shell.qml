// qmllint disable unqualified

import "services"
import "services/niri"
import "modules/bar"
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
}
