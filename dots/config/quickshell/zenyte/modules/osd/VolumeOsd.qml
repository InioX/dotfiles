import qs.services
import qs.modules.shared
import qs.modules.osd
import Quickshell
import QtQuick

import Quickshell.Services.Pipewire as QsPipewire

Loader {
    id: root
    property bool shouldShowOsd: false

    Connections {
        function onVolumeSinkChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
        }

        target: Pipewire
    }

    Timer {
        id: hideTimer

        interval: 1000
        onTriggered: root.shouldShowOsd = false
    }

    QsPipewire.PwObjectTracker {
        objects: [QsPipewire.defaultAudioSink]
    }

    active: shouldShowOsd

    sourceComponent: Osd {
        icon: "󰕾"
        value: Pipewire.volumeSink
        isActive: !Pipewire.mutedSink

        onMoved: {
            Pipewire.setVolumeSink(value);
        }
    }
}
