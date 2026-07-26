pragma Singleton
pragma ComponentBehavior: Bound
import qs.services
import qs.services.niri
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

Singleton {
    id: root

    property bool barWasAlreadyShowing: false
    property bool isLauncherOpened: false
    property bool isSoundSettingsOpened: false
    property bool isSettingsOpened: false

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

    property bool showInOverview: {
        if (!Compositors.isNiri) {
            return false;
        }

        return Niri.isOverview;
    }

    property bool showOnEmptyWorkspace: {
        if (Compositors.isNiri) {
            return !(Niri.focusedWindow && !Niri.focusedWindow.isFloating);
        }

        if (Compositors.isHyprland) {
            return Hyprland.focusedWorkspace.toplevels.values.length == 0;
        }

        return false;
    }

    property bool hasFullscreenWindow: {
        if (Compositors.isNiri) {
            return Niri.hasFullscreenToplevelOnScreen(Quickshell.screens[0]);
        }

        if (Compositors.isHyprland) {
            return Hyprland.focusedWorkspace.hasFullscreen;
        }

        return false;
    }
    readonly property bool baseBarVisibility: (Config.bar.visible.always && !hasFullscreenWindow) || (Config.bar.visible.overview && root.showInOverview) || (Config.bar.visible.empty_workspace && root.showOnEmptyWorkspace) || Config.bar.visible.on_top
    property bool forceShowBar: root.isLauncherOpened || root.isSoundSettingsOpened
    property bool showBar: baseBarVisibility || forceShowBar

    readonly property bool baseDockVisibility: (Config.dock.visible.always && !hasFullscreenWindow) || (Config.dock.visible.overview && root.showInOverview) || (Config.dock.visible.empty_workspace && root.showOnEmptyWorkspace) || Config.dock.visible.on_top

    property bool showDock: baseDockVisibility

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
