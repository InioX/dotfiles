// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.LocalStorage
import QtQuick.Effects
import Quickshell.Widgets

Item {
    id: root

    property bool isOpen: false
    required property int widgetX

    property string query: ""

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

    StyledPopout {
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

                TextField {
                    id: search

                    Layout.preferredWidth: 300
                    Layout.preferredHeight: 30

                    placeholderText: "Type to search"

                    enabled: true
                    focus: true
                    activeFocusOnPress: true

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

                ListView {
                    id: list

                    Layout.preferredWidth: 300
                    Layout.preferredHeight: 500

                    model: DesktopEntries.applications.values.filter(a => a.name.toLowerCase().includes(search.text))

                    highlight: Rectangle {
                        color: Colors.md3.surface_container_high
                        radius: 5
                    }

                    delegate: StyledText {
                        required property DesktopEntry modelData
                        text: modelData.name
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                // launch the app
                                modelData.execute();
                            }
                        }

                        color: Colors.md3.on_surface
                    }
                }
            }
        }
    }
}
