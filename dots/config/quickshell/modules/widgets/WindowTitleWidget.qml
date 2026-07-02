import qs.services
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Column {
    id: windowTitle

    readonly property string currentTitle: NiriService.focusedWindow.title || "Desktop"
    readonly property string currentClass: NiriService.focusedWindow.appId || "No active window"

    spacing: 2

    AnimatedTextWidget {
        displayText: windowTitle.currentTitle
        textColor: Colors.md3.on_surface
        fontSize: 14

        Component.onCompleted: {
            console.log(NiriService.focusedWindow.title);
        }
    }

    AnimatedTextWidget {
        displayText: windowTitle.currentClass
        textColor: Colors.md3.outline
        fontSize: 11
    }
}
