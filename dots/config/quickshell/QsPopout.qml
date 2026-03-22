import "./Services"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import QtQuick.Shapes
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets

WlrLayershell {
    id: qsPopout

    layer: WlrLayer.Overlay
    implicitWidth: 520
    implicitHeight: 320
    color: "transparent"
    exclusionMode: ExclusionMode.Normal

    anchors {
        top: true
        right: true
    }

    Rectangle {
        id: background

        anchors.fill: parent
        color: Colors.md3.surface
        bottomLeftRadius: 20

        ColumnLayout {
            id: layout

            anchors.fill: parent
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 20

            ColumnLayout {
                spacing: 20

                RowLayout {
                    spacing: 20

                    Text {
                        text: "󰕾"
                        color: Colors.md3.on_surface
                        font.bold: true
                        font.pixelSize: 25
                    }

                    Slider {
                        Layout.fillWidth: true
                        value: PipewireService.volumeSink
                    }

                }

                RowLayout {
                    spacing: 20

                    Text {
                        text: "󰃠"
                        color: Colors.md3.on_surface
                        font.bold: true
                        font.pixelSize: 25
                    }

                    Slider {
                        Layout.fillWidth: true
                        value: 100
                    }

                }

            }

            ColumnLayout {
                spacing: 20

                RowLayout {
                    spacing: 20

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 220
                        height: 40
                        color: Colors.md3.primary

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "HIIIIIII"
                            color: Colors.md3.on_primary
                        }

                    }

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 220
                        height: 40
                        color: Colors.md3.primary

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "HIIIIIII"
                            color: Colors.md3.on_primary
                        }

                    }

                }

                RowLayout {
                    spacing: 20

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 220
                        height: 40
                        color: Colors.md3.primary

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "HIIIIIII"
                            color: Colors.md3.on_primary
                        }

                    }

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 220
                        height: 40
                        color: Colors.md3.primary

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "HIIIIIII"
                            color: Colors.md3.on_primary
                        }

                    }

                }

            }

        }

    }

}
