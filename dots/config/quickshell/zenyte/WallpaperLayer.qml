import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Wayland

PanelWindow {
    id: desktopWindow

    anchors {
        left: true
        right: true
        top: true
        bottom: true
    }

    WlrLayershell.layer: WlrLayer.Background

    color: "transparent"

    DropArea {
        anchors.fill: parent

        keys: ["text/uri-list"]

        onDropped: drop => {
            if (drop.hasText) {
                let rawUrl = drop.text.trim();

                let filePath = rawUrl.replace(/^file:\/\//, "");

                filePath = decodeURIComponent(filePath).replace(/\r?\n|\r/g, "");

                if (filePath.match(/\.(jpg|jpeg|png|webp|gif)$/i)) {
                    wallpaperSetter.command[2] = filePath;
                    wallpaperSetter.running = true;
                }
            }
        }
    }

    Process {
        id: wallpaperSetter

        command: ["matugen", "image", "", "--type", "scheme-smart", "--mode", "dark", "--prefer", "saturation"]
    }
}
