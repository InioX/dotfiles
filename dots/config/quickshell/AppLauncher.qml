import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Io
import "./Services"
import "./Colors.qml"

WlrLayershell {
    id: launcher
    layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Normal
    
    keyboardFocus: WlrKeyboardFocus.OnDemand
    
    implicitWidth: 400
    implicitHeight: 680
    color: "transparent"

    anchors {
        bottom: true
    }
    
    property string query: ""



    function launchSelected() {
        if (list.currentItem && list.currentItem.modelData) {
            list.currentItem.modelData.execute();
            root.launcherVisible = false
        }
    }

    Rectangle {
        anchors.bottomMargin: 120

        id: background
        anchors.fill: parent
        color: Colors.md3.surface_container
        radius: 20
        clip: true
        border.color: Colors.md3.outline_variant
        border.width: 1

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
                color: Colors.md3.on_surface
                placeholderTextColor: Colors.md3.on_surface

                padding: 10

                onTextChanged: {
                    launcher.query = text;
                    list.currentIndex = filtered.values.length > 0 ? 0 : -1;
                }

                background: Rectangle {
                    border.width: 0
                    color: Colors.md3.surface_container_highest
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
                    color: Colors.md3.primary_container
                }

                delegate: Item {
                    id: entry
                    required property var modelData
                    required property int index
                    width: ListView.view.width
                    height: 60

                    MouseArea {
                        anchors.fill: parent
                        onClicked: list.currentIndex = entry.index
                        onDoubleClicked: launcher.launchSelected()
                    }

                    Row {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 10

                        Rectangle {
                            
                            width: imageIcon.width + 10
                            height: imageIcon.height + 6
                            color: Colors.md3.primary_container
                            radius: 20

                            IconImage {
                                id: imageIcon

                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                                // visible: false
                                source: Quickshell.iconPath(AppSearch.guessIcon(modelData.icon), "image-missing")
                                implicitSize: 40
                                layer.enabled: true
                                layer.smooth: true

                                MultiEffect {
                                    source: imageIcon
                                    anchors.fill: imageIcon
                                    colorization: 1
                                    colorizationColor: Colors.md3.on_primary_container
                                }

                                MouseArea {
                                    id: mouseArea

                                    hoverEnabled: true
                                    anchors.fill: parent
                                    onClicked: Hyprland.dispatch(`workspace ${modelData.workspace.id}`)

                                    ToolTip {
                                        visible: mouseArea.containsMouse
                                        delay: 500

                                        contentItem: Text {
                                            text: modelData.title || "Window"
                                            color: Colors.md3.on_surface
                                            font.pixelSize: 12
                                        }

                                        background: Rectangle {
                                            color: Colors.md3.surface
                                            border.color: Colors.md3.primary
                                            radius: 10
                                        }

                                    }

                                }

                            }

                        }

                        Column {
                            Text {
                                id: labelName
                                color: list.currentIndex === index ? Colors.md3.on_primary_container : Colors.md3.on_surface
                                text: modelData.name
                                font.pointSize: 15
                                font.bold: true
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }

                            Text {
                                id: labelDesc
                                color: list.currentIndex === index ? Colors.md3.on_primary_container : Colors.md3.outline
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