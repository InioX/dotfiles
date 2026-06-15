import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource
    readonly property bool mutedSource: source?.audio.muted ?? true
    readonly property bool mutedSink: sink?.audio.muted ?? true
    readonly property int volumeSource: source?.audio ? (source.audio.volume * 100) : 0
    readonly property int volumeSink: sink?.audio ? (sink.audio.volume * 100) : 0

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
}
