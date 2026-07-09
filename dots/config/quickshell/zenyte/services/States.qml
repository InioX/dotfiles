pragma Singleton
pragma ComponentBehavior: Bound
import qs.services
import qs.services.niri
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool barWasAlreadyShowing: false
    property bool isLauncherOpened: false

    readonly property bool baseBarVisibility: (Config.bar.show_in_overview && Niri.isOverview) || (Config.bar.show_on_empty_workspace && !Niri.focusedWindow) || Config.bar.show_on_top

    property bool showBar: baseBarVisibility || root.isLauncherOpened

    property bool exclusiveFocus: root.isLauncherOpened

    signal requestLauncherToggle

    IpcHandler {
        target: "root"

        function toggleLauncher(): void {
            // let barWasAlreadyShowing = (!root.isLauncherOpened && root.showBar) ? root.showBar : false;
            root.isLauncherOpened = true;
            root.requestLauncherToggle();
        }
    }
}
