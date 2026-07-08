pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource
    readonly property bool mutedSource: source?.audio.muted ?? true
    readonly property bool mutedSink: sink?.audio.muted ?? true
    readonly property int volumeSource: source?.audio ? (source.audio.volume * 100) : 0
    readonly property int volumeSink: sink?.audio ? (sink.audio.volume * 100) : 0

    function setVolumeSink(value) {
        const cmd = "wpctl set-volume @DEFAULT_AUDIO_SINK@ " + value * 100 + "%";
        setVolumeProcess.command = ["/bin/sh", "-c", cmd];
        setVolumeProcess.running = true;
    }

    function setVolumeSource(value) {
        const cmd = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ " + value * 100 + "%";
        setVolumeProcess.command = ["/bin/sh", "-c", cmd];
        setVolumeProcess.running = true;
    }

    Process {
        id: setVolumeProcess
        running: false
    }

    property var streamNodes: {
        const out = [];

        if (!Pipewire.ready || !Pipewire.nodes || !Pipewire.nodes.values)
            return out;

        for (const node of Pipewire.nodes.values) {
            if (node.isStream && node.audio) {
                out.push(node);
            }
        }
        return out;
    }

    property string icon: {
        if (mutedSink || volumeSink === 0)
            return "󰝟";

        if (volumeSink < 0.33)
            return "󰕿";

        if (volumeSink < 0.66)
            return "󰖀";

        return "󰕾";
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    PwObjectTracker {
        id: nodesTracker
        objects: streamNodes
    }
}
