pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Qt.labs.folderlistmodel

Singleton {
    id: root

    property int cpuTemp

    property real lastCpuIdle
    property real lastCpuTotal
    property real cpuPerc

    property real usedMemory
    property real usedMemoryPerc

    property real uptime

    // CPU Temperature
    FolderListModel {
        id: folderListModel
        folder: "file:///sys/class/hwmon"
    }

    FileView {
        id: hwmon

        property int index: 0
        property bool done: false
        property string fileName: "name"

        path: folderListModel.status === FolderListModel.Ready ? `file:///sys/class/hwmon/hwmon${Math.min(index, folderListModel.count - 1)}/${fileName}` : ""

        onLoaded: {
            if (!done) {
                if (text().includes("k10temp")) {
                    Qt.callLater(() => {
                        done = true;
                        fileName = "temp1_input";
                    });
                } else if (index < folderListModel.count - 1)
                    Qt.callLater(() => ++index);
            } else
                root.cpuTemp = Number(text()) / 1000;
        }
    }

    // Real-time CPU Usage
    FileView {
        id: procStat
        path: "file:///proc/stat"

        onLoaded: {
            const cpuTimes = text().split(' ').slice(2, 9).map(Number);

            const idle = cpuTimes[3] + cpuTimes[4];
            const total = cpuTimes.reduce((acc, cur) => acc + cur, 0);

            const idleDiff = idle - root.lastCpuIdle;
            const totalDiff = total - root.lastCpuTotal;

            root.cpuPerc = root.lastCpuTotal > 0 && totalDiff > 0 ? 1 - idleDiff / totalDiff : 0;

            root.lastCpuIdle = idle;
            root.lastCpuTotal = total;
        }
    }

    // Memory Usage
    FileView {
        id: procMemInfo
        path: "file:///proc/meminfo"

        onLoaded: {
            const memNumbers = text().split('\n').map(m => parseInt(m.split(':')[1]));

            root.usedMemory = (memNumbers[0] - memNumbers[2]) / (1024 * 1024);
            root.usedMemoryPerc = 1 - memNumbers[2] / memNumbers[0];
        }
    }

    // Uptime
    FileView {
        id: procUptime
        path: "file:///proc/uptime"

        onLoaded: root.uptime = parseInt(text())
    }

    // Update Timers
    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            hwmon.reload();
            procStat.reload();
            procMemInfo.reload();
        }
    }

    Timer {
        interval: 60000
        running: true
        repeat: true

        onTriggered: procUptime.reload()
    }
}
