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
    property bool isSoundSettingsOpened: false

    readonly property bool baseBarVisibility: (Config.bar.show_in_overview && Niri.isOverview) || (Config.bar.show_on_empty_workspace && !Niri.focusedWindow) || Config.bar.show_on_top

    property bool showBar: baseBarVisibility || root.isLauncherOpened || isSoundSettingsOpened

    property bool exclusiveFocus: root.isLauncherOpened

    signal requestLauncherToggle
    signal requestSoundSettingsToggle

    IpcHandler {
        target: "root"

        function toggleLauncher(): void {
            root.isLauncherOpened = true;
            root.requestLauncherToggle();
        }

        function toggleSoundSettings(): void {
            root.isSoundSettingsOpened = true;
            root.requestSoundSettingsToggle();
        }
    }
}
