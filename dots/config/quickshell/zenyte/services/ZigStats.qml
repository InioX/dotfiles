pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property var json: null
    property int timeout: 1000

    Process {
        id: dateProc

        command: ["hermes", "-i", root.timeout]
        running: true

        stdout: SplitParser {
            onRead: data => {
                try {
                    let parsed = JSON.parse(data);
                    root.json = parsed;
                } catch (e) {
                    console.error("Failed to parse JSON from daemon:", e);
                }
            }
        }
    }
}
