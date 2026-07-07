pragma Singleton
pragma ComponentBehavior: Bound
import qs.services
import QtQuick
import Quickshell

Singleton {
    id: root

    property bool showBar: true
}
