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

    property string launcherTab: {
        switch (launcherTabIndex) {
        case 0:
            return "apps";
        case 1:
            return "projects";
        default:
            return "apps";
        }
    }

    property int launcherTabIndex

    function cycleTabs() {
        if (launcherTabIndex == 0) {
            return launcherTabIndex = 1;
        }

        if (launcherTabIndex == 1) {
            return launcherTabIndex = 0;
        }

        launcherTabIndex += 1;
    }

    function previousTab() {
        if (launcherTabIndex == 0)
            return;
        launcherTabIndex -= 1;
    }

    function nextTab() {
        if (launcherTabIndex == 1)
            return;
        launcherTabIndex += 1;
    }

    readonly property bool baseBarVisibility: (Config.bar.show_in_overview && Niri.isOverview) || (Config.bar.show_on_empty_workspace && !Niri.focusedWindow) || Config.bar.show_on_top

    property bool showBar: baseBarVisibility || root.isLauncherOpened || isSoundSettingsOpened

    property bool exclusiveFocus: root.isLauncherOpened

    property bool wasLauncherOpened: false

    signal requestLauncherToggle
    signal requestSoundSettingsToggle

    function toggleTab(tabIndex) {
        if (!root.isLauncherOpened) {
            root.isLauncherOpened = true;
            root.requestLauncherToggle();
        } else {
            if (root.launcherTabIndex == tabIndex) {
                root.requestLauncherToggle();
            }
        }

        if (root.launcherTabIndex !== tabIndex) {
            return root.launcherTabIndex = tabIndex;
        }
    }

    IpcHandler {
        target: "root"

        function toggleLauncher(): void {
            root.toggleTab(0);
        }

        function toggleLauncherPosition(): void {
            Config.bar.bottom = !Config.bar.bottom;
        }

        function toggleSoundSettings(): void {
            root.isSoundSettingsOpened = true;
            root.requestSoundSettingsToggle();
        }

        function toggleProjectSearch(): void {
            root.toggleTab(1);
        }
    }
}
