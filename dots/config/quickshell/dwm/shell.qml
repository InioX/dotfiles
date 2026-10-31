//@ pragma UseQApplication
// qmllint disable unqualified

import "services"
import "modules/shared"
import "modules/bar"

import QtQuick
import Quickshell

ShellRoot {
    id: root

    Loader {
        active: true

        sourceComponent: Bar {}
    }
}
