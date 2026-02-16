import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Io
       
WlrLayershell {
    id: launcher
    layer: WlrLayer.Overlay
    
    keyboardFocus: WlrKeyboardFocus.Exclusive
    
    width: 560
    height: 360
    color: colors.surface
    
    exclusionMode: ExclusionMode.None

    property string query: ""



    function launchSelected() {
        if (list.currentItem && list.currentItem.modelData) {
            list.currentItem.modelData.execute();
            root.launcherVisible = false
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

        RowLayout {
            IconImage {
                Layout.leftMargin: 10
                source: Quickshell.iconPath("nix-snowflake", true)
                Layout.preferredWidth: 25
                Layout.preferredHeight: 25
            }

            TextField {
                id: input
                Layout.fillWidth: true
                placeholderText: "Run…"
                font.pixelSize: 18
                color: "white"
                focus: true

                padding: 15

                onTextChanged: {
                    launcher.query = text;
                    list.currentIndex = filtered.values.length > 0 ? 0 : -1;
                }

                background: Rectangle {
                    border.width: 0
                    color: "transparent"
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

        // Filtered model: only items matching the query
        ScriptModel {
            id: filtered
            values: {
                const allEntries = [...DesktopEntries.applications.values];
                const q = launcher.query.trim();

                if (q === "") {
                    return allEntries;
                } else {
                    return allEntries.filter(d => d.name && d.name.toLowerCase().includes(q));
                }
            }
        }

        ListView {
            id: list
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: filtered.values
            currentIndex: filtered.values.length > 0 ? 0 : -1
            keyNavigationWraps: true
            preferredHighlightBegin: 0
            preferredHighlightEnd: height
            highlightRangeMode: ListView.ApplyRange
            highlightMoveDuration: 80
            highlight: Rectangle {
                radius: 4
                color: input.palette.highlight
            }

            delegate: Item {
                id: entry
                required property var modelData
                required property int index
                width: ListView.view.width
                height: 50

                MouseArea {
                    anchors.fill: parent
                    onClicked: list.currentIndex = entry.index
                    onDoubleClicked: launcher.launchSelected()
                }

                Row {
                    anchors.fill: parent
                    anchors.margins: 8
                    spacing: 10

                    IconImage {
                        source: Quickshell.iconPath(modelData.icon, true)
                        width: 35
                        height: 35
                    }
                    Text {
                        id: label
                        color: "white"
                        text: modelData.name
                        font.pointSize: 20
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }

            // Enter also works while ListView has focus
            Keys.onReturnPressed: launcher.launchSelected()
        }
    }
}