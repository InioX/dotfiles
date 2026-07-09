// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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

    function launchSelected() {
        if (list.currentItem && list.currentItem.modelData) {
            list.currentItem.modelData.execute();
            root.launcherVisible = false;
        }
    }

    StyledPopout {
        isOpen: root.isOpen

        wantedHeight: Math.max(10, column.implicitHeight + 60)
        wantedWidth: 500

        parentX: widgetX - (wantedWidth / 2)

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
                    id: input
                    Layout.fillWidth: true
                    placeholderText: "󰍉"
                    font.bold: true
                    font.pixelSize: 20
                    focus: true
                    color: Colors.md3.on_surface
                    placeholderTextColor: Colors.md3.on_surface

                    padding: 10

                    onTextChanged: {
                        root.query = text;
                        list.currentIndex = filtered.values.length > 0 ? 0 : -1;
                    }

                    background: Rectangle {
                        border.width: 0
                        color: Colors.md3.surface_container_highest
                        radius: Config.bar.widget_radius
                    }

                    Keys.onEscapePressed: root.launcherVisible = false
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
                            launcher.launchSelected();
                        } else if (event.key == Qt.Key_C && ctrl) {
                            event.accepted = true;
                            root.launcherVisible = false;
                        }
                    }
                }
            }
        }
    }
}
