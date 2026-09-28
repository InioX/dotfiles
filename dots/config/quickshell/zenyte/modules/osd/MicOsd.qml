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
        function onVolumeSourceChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
        }

        function onMutedSourceChanged() {
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
        objects: [QsPipewire.defaultAudioSource]
    }

    active: shouldShowOsd

    sourceComponent: Osd {
        icon: Pipewire.mutedSource ? "󰍭" : "󰍬"
        value: Pipewire.volumeSource
        isActive: !Pipewire.mutedSource

        onMoved: {
            Pipewire.setVolumeSource(value);
        }
    }
}
