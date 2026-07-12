// qmllint disable unqualified

import qs.services
import qs.modules.shared
import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import QtQuick.Effects
import Quickshell.Widgets
import Qt.labs.folderlistmodel 2.11

Item {
    id: root

    property bool isOpen: false
    required property int widgetX

    property string query: ""
    property string currentTab: States.launcherTab
    property var pinnedAppIds: Config.launcher.pinned_apps

    signal animationCloseFinished

    Timer {
        id: destroyTimer
        interval: 150
        onTriggered: root.animationCloseFinished()
    }

    FolderListModel {
        id: devFolderModel
        folder: "file://" + Quickshell.env("HOME") + "/dev"
        showDirs: true
        showFiles: false
        showHidden: false
        showDotAndDotDot: false
    }

    onIsOpenChanged: {
        if (!isOpen) {
            destroyTimer.start();
        } else {
            destroyTimer.stop();
        }
    }

    function togglePin(appId) {
        let pins = Config.launcher.pinned_apps;

        Config.launcher.pinned_apps = pins.includes(appId) ? pins.filter(id => id !== appId) : [...pins, appId];

        Config.saveConfig();
    }

    function isAppPinned(appId) {
        return pinnedAppIds.indexOf(appId) !== -1;
    }

    StyledPopout {
        id: popout

        isOpen: root.isOpen

        wantedHeight: Math.max(10, column.implicitHeight + 60)
        wantedWidth: 500
        anchor.window: barWindow
        anchor.gravity: Config.bar.bottom ? (Edges.Top | Edges.Right) : (Edges.Bottom | Edges.Right)

        property int parentX: widgetX - (wantedWidth / 2)

        anchor.rect.x: Math.max(offset, Math.min(parentX, parentWindow.width - width - offset))
        anchor.rect.y: Config.bar.bottom ? (0 - Config.bar.margins.popout) : (parentWindow.height + Config.bar.margins.popout)

        grabFocus: true

        StyledRoundRect {
            id: rect

            opacity: root.isOpen ? 1.0 : 0.9

            Behavior on opacity {
                StyledNumberAnimation {}
            }

            ColumnLayout {
                id: column

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top

                spacing: 20
                anchors.margins: 20

                Item {
                    id: tabBarContainer
                    Layout.fillWidth: true
                    Layout.preferredHeight: 52

                    Rectangle {
                        id: baseline
                        height: 2
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        color: Colors.md3.outline_variant
                        z: 0
                    }

                    RowLayout {
                        id: tabRow
                        anchors.fill: parent
                        spacing: 0

                        Repeater {
                            id: tabRepeater
                            model: [
                                {
                                    tab: "apps",
                                    tabName: "Applications",
                                    icon: "󰀻"
                                },
                                {
                                    tab: "projects",
                                    tabName: "Projects",
                                    icon: "󰉖"
                                }
                            ]

                            delegate: Rectangle {
                                id: tabDelegate
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                color: "transparent"

                                property bool isActive: root.currentTab === modelData.tab

                                Column {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.bottom: parent.bottom
                                    anchors.bottomMargin: 8
                                    spacing: 2

                                    StyledText {
                                        text: modelData.icon
                                        color: tabDelegate.isActive ? Colors.md3.primary : Colors.md3.on_surface
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: Config.style.font.size.icon_small
                                    }

                                    StyledText {
                                        id: labelText
                                        text: modelData.tabName
                                        color: tabDelegate.isActive ? Colors.md3.primary : Colors.md3.on_surface
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: Config.style.font.size.small
                                    }
                                }

                                StyledMouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        States.launcherTab = modelData.tab;
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: activeIndicator
                        height: 2
                        color: Colors.md3.primary
                        z: 2
                        anchors.bottom: parent.bottom

                        property var activeItem: {
                            for (var i = 0; i < tabRepeater.count; i++) {
                                var item = tabRepeater.itemAt(i);
                                if (item && item.isActive)
                                    return item;
                            }
                            return null;
                        }

                        width: activeItem ? activeItem.width : 0
                        x: activeItem ? activeItem.x : 0

                        Behavior on x {
                            StyledSpringAnimation {}
                        }

                        Behavior on width {
                            StyledSpringAnimation {}
                        }
                    }
                }

                StyledSearch {
                    id: searchBar

                    placeHolderString: {
                        if (root.currentTab) {
                            return "Type to search " + root.currentTab;
                        } else {
                            return "Type to search";
                        }
                    }

                    onTextChanged: {
                        root.query = searchBar.text;
                        list.currentIndex = filtered.values.length > 0 ? 0 : -1;
                    }

                    Keys.onPressed: event => {
                        const ctrl = event.modifiers & Qt.ControlModifier;
                        const alt = event.modifiers & Qt.AltModifier;
                        if (event.key == Qt.Key_Up || event.key == Qt.Key_P && ctrl) {
                            event.accepted = true;
                            if (list.currentIndex > 0)
                                list.currentIndex--;
                        } else if (event.key == Qt.Key_Left && alt) {
                            event.accepted = true;
                            States.previousTab();
                        } else if (event.key == Qt.Key_Right && alt) {
                            event.accepted = true;
                            States.nextTab();
                        } else if (event.key == Qt.Key_Tab) {
                            event.accepted = true;
                            States.cycleTabs();
                        } else if (event.key == Qt.Key_Down || event.key == Qt.Key_N && ctrl) {
                            event.accepted = true;
                            if (list.currentIndex < list.count - 1)
                                list.currentIndex++;
                        } else if ([Qt.Key_Return, Qt.Key_Enter].includes(event.key) && ctrl) {
                            event.accepted = true;

                            if (list.currentItem && list.currentItem.modelData) {
                                root.togglePin(list.currentItem.modelData.id);
                            }
                        } else if ([Qt.Key_Return, Qt.Key_Enter].includes(event.key)) {
                            event.accepted = true;

                            if (list.currentItem && list.currentItem.modelData) {
                                if (root.currentTab === "apps") {
                                    list.currentItem.modelData.execute();
                                } else {
                                    projectOpener.command[1] = list.currentItem.modelData.path;
                                    projectOpener.running = true;
                                }
                                root.isOpen = false;
                            }

                            root.isOpen = false;
                        } else if (event.key == Qt.Key_C && ctrl) {
                            event.accepted = true;
                            root.isOpen = false;
                        }
                    }
                }

                ScriptModel {
                    id: filtered
                    values: {
                        if (root.currentTab == "apps") {
                            const pinTracker = root.pinnedAppIds;
                            let allEntries = [...DesktopEntries.applications.values];
                            const q = root.query.trim().toLowerCase();

                            if (q !== "") {
                                allEntries = allEntries.filter(d => d.name && d.name.toLowerCase().includes(q));
                            }

                            allEntries.sort((a, b) => {
                                let aPinned = root.isAppPinned(a.id);
                                let bPinned = root.isAppPinned(b.id);

                                if (aPinned === bPinned) {
                                    return a.name.localeCompare(b.name);
                                }
                                return aPinned ? -1 : 1;
                            });

                            return allEntries;
                        } else {
                            let projectEntries = [];
                            const q = root.query.trim().toLowerCase();

                            for (let i = 0; i < devFolderModel.count; i++) {
                                let name = devFolderModel.get(i, "fileName");
                                let path = devFolderModel.get(i, "filePath");

                                if (q === "" || name.toLowerCase().includes(q)) {
                                    projectEntries.push({
                                        name: name,
                                        path: path,
                                        isProject: true
                                    });
                                }
                            }

                            projectEntries.sort((a, b) => a.name.localeCompare(b.name));
                            return projectEntries;
                        }
                    }
                }

                StyledListView {
                    id: list

                    model: filtered.values
                    currentIndex: filtered.values.length > 0 ? 0 : -1
                    // visible: root.currentTab == "apps"

                    delegate: Item {
                        id: listDelegate

                        required property var modelData
                        required property int index

                        width: ListView.view.width
                        height: 60

                        StyledMouseArea {
                            hoverEnabled: true
                            onClicked: list.currentIndex = index
                            onDoubleClicked: {
                                if (root.currentTab === "apps") {
                                    listDelegate.modelData.execute();
                                } else {
                                    projectOpener.command[1] = listDelegate.modelData.path;
                                    projectOpener.running = true;
                                }
                                root.isOpen = false;
                            }
                        }

                        RowLayout {
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.right: parent.right

                            spacing: 10

                            anchors.leftMargin: 20
                            anchors.rightMargin: 20

                            StyledAppIcon {
                                icon: root.currentTab === "apps" ? listDelegate.modelData.icon : "folder"
                                wantedSize: 36

                                Layout.alignment: Qt.AlignVCenter
                            }

                            Column {
                                Layout.alignment: Qt.AlignVCenter
                                Layout.fillWidth: true

                                StyledText {
                                    text: root.currentTab === "apps" ? listDelegate.modelData.name : listDelegate.modelData.name

                                    font.pixelSize: Config.style.font.size.medium
                                    color: Colors.md3.on_surface
                                }

                                StyledText {
                                    text: root.currentTab === "apps" ? listDelegate.modelData.id : listDelegate.modelData.path

                                    font.pixelSize: Config.style.font.size.small
                                    color: Colors.md3.outline_variant
                                }
                            }

                            Rectangle {
                                id: pinButton

                                visible: root.currentTab === "apps"
                                property bool isPinned: root.isAppPinned(listDelegate.modelData.id)

                                implicitHeight: parent.implicitHeight - 10
                                implicitWidth: parent.implicitHeight - 10
                                color: pinButton.isPinned ? Colors.md3.primary : Colors.md3.surface_container_high
                                radius: 40

                                Layout.alignment: Qt.AlignVCenter

                                StyledText {
                                    anchors.fill: parent

                                    text: pinButton.isPinned ? "󰐃" : "󰤱"
                                    color: pinButton.isPinned ? Colors.md3.on_primary : Colors.md3.on_surface

                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter

                                    font.pixelSize: Config.style.font.size.icon_small

                                    Behavior on color {
                                        StyledColorAnimation {}
                                    }
                                }

                                StyledMouseArea {
                                    id: pinMouseArea

                                    onClicked: {
                                        root.togglePin(listDelegate.modelData.id);
                                    }
                                }

                                Behavior on color {
                                    StyledColorAnimation {}
                                }
                            }
                        }
                    }
                }

                StyledText {
                    visible: list.contentHeight <= 0 | !list.visible

                    text: "Could not find any " + root.currentTab + " (╥﹏╥)"
                    font.pixelSize: Config.style.font.size.small
                    color: Colors.md3.on_surface
                    Layout.alignment: Qt.AlignHCenter
                }
            }

            Process {
                id: projectOpener

                command: ["zeditor", ""]
            }
        }
    }
}
