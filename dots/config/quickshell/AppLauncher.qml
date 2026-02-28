import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Io
import "./Services"
       
WlrLayershell {
    id: launcher
    layer: WlrLayer.Overlay
    
    keyboardFocus: WlrKeyboardFocus.Exclusive
    
    implicitWidth: 400
    implicitHeight: 600
    color: "transparent"

    anchors {
        top: true
    }
    
    exclusionMode: ExclusionMode.Ignore

    property string query: ""



    function launchSelected() {
        if (list.currentItem && list.currentItem.modelData) {
            list.currentItem.modelData.execute();
            root.launcherVisible = false
        }
    }

    Rectangle {
        anchors.topMargin: root.panelHeight

        id: background
        anchors.fill: parent
        color: colors.surface
        bottomRightRadius: 20
        bottomLeftRadius: 20
        clip: true

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 8

            TextField {
                Layout.fillWidth: true

                id: input
                placeholderText: "󰍉"
                font.bold: true
                font.pixelSize: 20
                focus: true
                color: colors.on_surface
                placeholderTextColor: colors.on_surface

                padding: 10

                onTextChanged: {
                    launcher.query = text;
                    list.currentIndex = filtered.values.length > 0 ? 0 : -1;
                }

                background: Rectangle {
                    border.width: 0
                    color: colors.surface_container
                    radius: root.cornerRadius
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
                    radius: root.cornerRadius
                    color: colors.primary_container
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
                            source: Quickshell.iconPath(AppSearch.guessIcon(modelData.icon), "image-missing")
                            width: 35
                            height: 35
                        }

                        Column {
                            Text {
                                id: labelName
                                color: list.currentIndex === index ? colors.on_primary_container : colors.on_surface
                                text: modelData.name
                                font.pointSize: 15
                                font.bold: true
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }

                            Text {
                                id: labelDesc
                                color: list.currentIndex === index ? colors.on_primary_container : colors.outline
                                text: modelData.comment || "No description provided."
                                font.pointSize: 8
                                font.bold: true
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                    }
                }

                // Enter also works while ListView has focus
                Keys.onReturnPressed: launcher.launchSelected()
            }
        }   
    }
}