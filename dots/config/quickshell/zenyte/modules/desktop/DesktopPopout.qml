// qmllint disable unqualified
pragma ComponentBehavior: Bound

import qs.services
import qs.modules.shared
import qs.modules.desktop
import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    property bool isOpen: false
    required property int widgetX
    required property int widgetY

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

        wantedHeight: column.implicitHeight + 40
        wantedWidth: 300

        anchor.rect.x: widgetX
        anchor.rect.y: widgetY

        anchor.window: wallpaperLayer

        StyledRoundRect {
            id: rect

            StyledMouseArea {
                id: desktopPopoutMouseArea
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                anchors.fill: parent

                cursorShape: Qt.Normal

                onClicked: mouse => {
                    if (mouse.button === Qt.RightButton) {
                        root.isOpen = false;
                    }
                }
            }

            ColumnLayout {
                id: column

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top

                spacing: 10
                anchors.margins: 20

                PopoutEntry {
                    Layout.fillWidth: true

                    StyledCheckBox {
                        checked: Config.desktop.show_icons
                        text: qsTr("Show Desktop Icons")
                        onClicked: {
                            Config.desktop.show_icons = !Config.desktop.show_icons;
                            Config.saveConfig();
                        }
                    }

                    onClicked: {
                        Config.desktop.show_icons = !Config.desktop.show_icons;
                        Config.saveConfig();
                    }
                }

                PopoutEntry {
                    Layout.fillWidth: true

                    StyledCheckBox {
                        checked: Config.desktop.show_files
                        text: qsTr("Show Files")
                        onClicked: {
                            Config.desktop.show_files = !Config.desktop.show_files;
                            Config.saveConfig();
                        }
                    }

                    onClicked: {
                        Config.desktop.show_files = !Config.desktop.show_files;
                        Config.saveConfig();
                    }
                }

                PopoutEntry {
                    Layout.fillWidth: true

                    StyledCheckBox {
                        checked: Config.desktop.show_folders
                        text: qsTr("Show Folders")
                        onClicked: {
                            Config.desktop.show_folders = !Config.desktop.show_folders;
                            Config.saveConfig();
                        }
                    }

                    onClicked: {
                        Config.desktop.show_folders = !Config.desktop.show_folders;
                        Config.saveConfig();
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 2

                    color: Colors.md3.outline_variant
                }

                PopoutEntry {
                    Layout.fillWidth: true

                    RowLayout {
                        spacing: 16
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom

                        StyledText {
                            leftPadding: 8
                            text: "󰉖"
                            color: Colors.md3.on_surface
                            font.pixelSize: Config.style.font.size.icon_medium
                        }

                        StyledText {
                            text: "Open Files"
                            color: Colors.md3.on_surface
                            font.pixelSize: Config.style.font.size.small

                            leftPadding: parent.spacing
                        }
                    }

                    onClicked: {
                        Quickshell.execDetached("nautilus");
                        root.isOpen = false;
                    }
                }

                PopoutEntry {
                    Layout.fillWidth: true

                    RowLayout {
                        spacing: 16
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom

                        StyledText {
                            leftPadding: 8
                            text: "󰍛"
                            color: Colors.md3.on_surface
                            font.pixelSize: Config.style.font.size.icon_medium
                        }

                        StyledText {
                            text: "Open Resource Monitor"
                            color: Colors.md3.on_surface
                            font.pixelSize: Config.style.font.size.small

                            leftPadding: parent.spacing
                        }
                    }
                    onClicked: {
                        Quickshell.execDetached("resources");
                        root.isOpen = false;
                    }
                }

                PopoutEntry {
                    Layout.fillWidth: true

                    RowLayout {
                        spacing: 16
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom

                        StyledText {
                            leftPadding: 8
                            text: "󰒓"
                            color: Colors.md3.on_surface
                            font.pixelSize: Config.style.font.size.icon_medium
                        }

                        StyledText {
                            text: "Open Settings"
                            color: Colors.md3.on_surface
                            font.pixelSize: Config.style.font.size.small

                            leftPadding: parent.spacing
                        }
                    }
                    onClicked: {
                        States.isSettingsOpened = true;
                        root.isOpen = false;
                    }
                }
            }
        }
    }
}
