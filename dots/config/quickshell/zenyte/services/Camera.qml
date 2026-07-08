pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool isShutterClosed

    Process {
        id: camCheck

        running: true
        command: ["v4l2-ctl", "-d", "/dev/video0", "--get-ctrl=privacy"]

        stdout: StdioCollector {
            onStreamFinished: {
                const text = String(data).trim();
                root.isShutterClosed = text.includes("privacy: 1");
            }
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            camCheck.running = false;
            camCheck.running = true;
        }
    }
}
