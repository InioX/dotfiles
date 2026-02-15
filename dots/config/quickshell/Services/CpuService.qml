import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    property real usage: 0
    // Internal state for calculation
    property var _lastTotal: 0
    property var _lastIdle: 0

    Process {
        id: cpuProc

        command: ["cat", "/proc/stat"]
        running: false

        stdout: SplitParser {
            onRead: (data) => {
                // We only care about the first line (aggregate cpu)
                if (data.startsWith("cpu ")) {
                    let parts = data.split(/\s+/).filter(Boolean);
                    // Column 4 is idle time, the rest (1-7) are various work states
                    let idle = parseInt(parts[4]);
                    let total = parts.slice(1).reduce((acc, v) => {
                        return acc + parseInt(v);
                    }, 0);
                    if (_lastTotal !== 0) {
                        let diffTotal = total - _lastTotal;
                        let diffIdle = idle - _lastIdle;
                        usage = Math.round(((diffTotal - diffIdle) / diffTotal) * 100);
                    }
                    _lastTotal = total;
                    _lastIdle = idle;
                }
            }
        }

    }

    Timer {
        interval: 2000 // Update every 2 seconds to keep CPU low
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: cpuProc.running = true
    }

}
