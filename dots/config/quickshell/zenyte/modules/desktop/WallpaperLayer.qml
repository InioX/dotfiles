import Quickshell
import QtQuick
import QtQuick.Effects
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Wayland
import qs.services
import qs.services.niri
import qs.modules.shared
import Qt.labs.folderlistmodel 2.11

Item {
    id: root
    property int mouseX: 0
    property int mouseY: 0
    property alias screen: wallpaperLayer.screen

    function open() {
        if (!desktopPopoutLoader.active) {
            desktopPopoutLoader.active = true;
        } else {
            if (desktopPopoutLoader.item) {
                desktopPopoutLoader.item.isOpen = false;
            }
        }
    }

    PanelWindow {
        id: wallpaperLayer

        anchors {
            left: true
            right: true
            top: true
            bottom: true
        }

        WlrLayershell.layer: WlrLayer.Background

        color: "transparent"

        FolderListModel {
            id: desktopModel
            folder: "file://" + Quickshell.env("HOME") + ""
            showDirs: Config.desktop.show_folders
            showFiles: Config.desktop.show_files
            showDotAndDotDot: false
            nameFilters: ["*"]
        }

        GridView {
            id: desktopGrid
            anchors.fill: parent
            anchors.margins: 20
            cellWidth: 90
            cellHeight: 100
            flow: GridView.FlowTopToBottom
            interactive: false

            visible: Config.desktop.show_icons

            model: desktopModel

            delegate: Item {
                width: desktopGrid.cellWidth
                height: desktopGrid.cellHeight

                Column {
                    anchors.centerIn: parent
                    spacing: 5

                    IconImage {
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: fileIsDir ? Quickshell.iconPath("folder", "image-missing") : Quickshell.iconPath("text-x-generic", "image-missing")
                        implicitSize: 60
                    }

                    Text {
                        text: fileName
                        color: "white"
                        width: desktopGrid.cellWidth - 10
                        horizontalAlignment: Text.AlignHCenter
                        elide: Text.ElideRight
                        font.pointSize: 10
                        style: Text.Outline
                        styleColor: "black"
                    }
                }

                StyledMouseArea {
                    anchors.fill: parent
                    onDoubleClicked: {
                        // if (fileIsDir) {
                        folderOpener.command = ["xdg-open", fileUrl];
                        folderOpener.running = true;
                        // }
                    }
                }
            }
        }

        Process {
            id: folderOpener
        }

        MouseArea {
            id: selectionArea
            anchors.fill: parent
            z: -1

            Connections {
                target: Niri

                function onFocusedWorkspaceChanged() {
                    if (desktopPopoutLoader.item) {
                        desktopPopoutLoader.item.isOpen = false;
                    }
                }

                function onFocusedWindowChanged() {
                    if (desktopPopoutLoader.item) {
                        desktopPopoutLoader.item.isOpen = false;
                    }
                }
            }

            acceptedButtons: Qt.LeftButton | Qt.RightButton

            property point startPoint
            property bool isDragging: false

            onPressed: mouse => {
                if (mouse.button === Qt.LeftButton) {
                    startPoint = Qt.point(mouse.x, mouse.y);
                    selectionBox.x = mouse.x;
                    selectionBox.y = mouse.y;
                    selectionBox.width = 0;
                    selectionBox.height = 0;

                    if (desktopPopoutLoader.active) {
                        root.open();
                    }
                }
            }

            onClicked: mouse => {
                if (mouse.button === Qt.RightButton) {
                    if (!desktopPopoutLoader.active) {
                        root.mouseX = mouse.x;
                        root.mouseY = mouse.y;
                    }

                    root.open();
                }
            }

            onPositionChanged: mouse => {
                if (pressed && (mouse.buttons & Qt.LeftButton)) {
                    isDragging = true;
                    selectionBox.x = Math.min(startPoint.x, mouse.x);
                    selectionBox.y = Math.min(startPoint.y, mouse.y);
                    selectionBox.width = Math.abs(startPoint.x - mouse.x);
                    selectionBox.height = Math.abs(startPoint.y - mouse.y);
                }
            }

            onReleased: mouse => {
                if (mouse.button === Qt.LeftButton) {
                    isDragging = false;
                    selectionBox.width = 0;
                    selectionBox.height = 0;
                }
            }

            Rectangle {
                id: selectionBox
                color: Colors.getColorWithAlpha(Colors.md3.primary, 0.2)
                border.color: Colors.getColorWithAlpha(Colors.md3.primary, 0.6)
                border.width: 1
                radius: 10
                visible: selectionArea.isDragging
            }
        }

        DropArea {
            anchors.fill: parent

            keys: ["text/uri-list"]

            onDropped: drop => {
                if (drop.hasText) {
                    let rawUrl = drop.text.trim();

                    let filePath = rawUrl.replace(/^file:\/\//, "");

                    filePath = decodeURIComponent(filePath).replace(/\r?\n|\r/g, "");

                    if (filePath.match(/\.(jpg|jpeg|png|webp|gif)$/i)) {
                        wallpaperSetter.command[2] = filePath;
                        wallpaperSetter.running = true;
                    }
                }
            }
        }

        LazyLoader {
            id: desktopPopoutLoader
            active: false
            component: DesktopPopout {
                isOpen: desktopPopoutLoader.active

                widgetX: root.mouseX
                widgetY: root.mouseY

                onAnimationCloseFinished: {
                    desktopPopoutLoader.active = false;
                }
            }
        }

        Process {
            id: wallpaperSetter

            command: ["matugen", "image", "", "--type", "scheme-smart", "--mode", "dark", "--prefer", "saturation"]
        }
    }
}
