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

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }   
}
