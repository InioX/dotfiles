pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import qs.services
import qs.services.niri

Singleton {
    id: root

    property bool isHyprland: false
    property bool isNiri: false
    property bool isSway: false
    property bool isGnome: false
    property bool isKwin: false
    property bool isLabwc: false
    property string compositor: ZigStats.json?.compositor
    property bool compositorDetected

    Timer {
        id: compositorInitTimer
        interval: 100
        running: true
        repeat: false
        onTriggered: {
            console.log(root.compositor);
            detectCompositor(ZigStats.json?.compositor);

            compositorDetected = true;
            Qt.callLater(() => {
            // NiriService.generateNiriLayoutConfig();
            // HyprlandService.generateLayoutConfig();
            // MangoService.generateLayoutConfig();
            });
        }
    }

    function detectCompositor(name) {
        isHyprland = name === "hyprland";
        isNiri = name === "niri";
        isSway = name === "sway";
        isGnome = name === "gnome";
        isKwin = name === "kwin";
        isLabwc = name === "labwc";
        compositor = name;
        compositorDetected = true;

        if (isNiri)
            NiriService.generateNiriBlurrule();
    }
}
