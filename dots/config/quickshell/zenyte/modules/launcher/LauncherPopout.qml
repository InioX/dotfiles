// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import QtQuick.Effects
import Quickshell.Widgets

Item {
    id: root

    property bool isOpen: false
    required property int widgetX

    property string query: ""
    property var pinnedAppIds: Config.launcher.pinned_apps

    signal animationCloseFinished

    Timer {
        id: destroyTimer
        interval: 150
        onTriggered: root.animationCloseFinished()
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

    property int entryRadius: 24

    StyledPopout {
        id: popout

        isOpen: root.isOpen

        wantedHeight: Math.max(10, column.implicitHeight + 60)
        wantedWidth: 500

        parentX: widgetX - (wantedWidth / 2)
        grabFocus: true

        StyledRoundRect {
            id: rect

            ColumnLayout {
                id: column

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top

                spacing: 20
                anchors.margins: 20

                StyledSearch {
                    id: searchBar

                    onTextChanged: {
                        root.query = searchBar.text;
                        list.currentIndex = filtered.values.length > 0 ? 0 : -1;
                    }

                    Keys.onPressed: event => {
                        const ctrl = event.modifiers & Qt.ControlModifier;
                        if (event.key == Qt.Key_Up || event.key == Qt.Key_P && ctrl) {
                            event.accepted = true;
                            if (list.currentIndex > 0)
                                list.currentIndex--;
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
                                list.currentItem.modelData.execute();
                                root.isOpen = false;
                            }
                        } else if (event.key == Qt.Key_C && ctrl) {
                            event.accepted = true;
                            root.isOpen = false;
                        }
                    }
                }

                ScriptModel {
                    id: filtered
                    values: {
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
                    }
                }

                ListView {
                    id: list

                    Layout.fillWidth: true
                    Layout.maximumHeight: 500
                    Layout.preferredHeight: list.contentHeight

                    model: filtered.values
                    currentIndex: filtered.values.length > 0 ? 0 : -1

                    highlight: Rectangle {
                        color: Colors.md3.surface_container
                        radius: root.entryRadius
                    }

                    highlightMoveDuration: 80

                    delegate: Item {
                        required property DesktopEntry modelData
                        required property int index

                        width: ListView.view.width
                        height: 60

                        StyledMouseArea {
                            hoverEnabled: true
                            onClicked: list.currentIndex = index
                            onDoubleClicked: {
                                modelData.execute();
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
                                icon: modelData.icon
                                wantedSize: 36

                                Layout.alignment: Qt.AlignVCenter
                            }

                            Column {
                                Layout.alignment: Qt.AlignVCenter
                                Layout.fillWidth: true

                                StyledText {
                                    text: modelData.name

                                    font.pixelSize: Config.style.font.size.medium
                                    color: Colors.md3.on_surface
                                }

                                StyledText {
                                    text: modelData.id

                                    font.pixelSize: Config.style.font.size.small
                                    color: Colors.md3.outline_variant
                                }
                            }

                            Rectangle {
                                id: pinButton

                                property bool isPinned: root.isAppPinned(modelData.id)

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
                                        root.togglePin(modelData.id);
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
                    visible: list.contentHeight <= 0

                    text: "No apps found (╥﹏╥)"
                    font.pixelSize: Config.style.font.size.small
                    color: Colors.md3.on_surface
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
    }
}
