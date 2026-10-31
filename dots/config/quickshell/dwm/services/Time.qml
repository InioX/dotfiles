pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string time
    property string month

    Process {
        id: dateProc

        command: ["date", "+%R"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.time = this.text
        }
    }

    Process {
        id: monthProc

        command: ["date", "+%a, %B %d"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.month = this.text
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            dateProc.running = true;
            monthProc.running = true;
        }
    }
}
