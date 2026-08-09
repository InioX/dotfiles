pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string username
    // property string iconPath: Quickshell.env("HOME") + "/pics/icon.jpg"
    property string iconPath: Quickshell.env("HOME") + "/pics/icon.jpg"

    Process {
        id: usernameProc

        command: ["whoami"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.username = this.text
        }
    }
}
