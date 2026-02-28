import "./Services"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets

WlrLayershell {
    id: qsPopout

    layer: WlrLayer.Overlay
    implicitWidth: 500
    implicitHeight: 300
    color: "transparent"
    exclusionMode: ExclusionMode.Normal

    anchors {
        top: true
        right: true
    }

    Rectangle {
        id: background

        anchors.fill: parent
        color: colors.surface
        bottomRightRadius: 20
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
                        color: colors.on_surface
                        font.bold: true
                        font.pixelSize: 25
                    }

                    Slider {
                        value: PipewireService.volumeSink
                    }

                }

                RowLayout {
                    spacing: 20

                    Text {
                        text: "󰃠"
                        color: colors.on_surface
                        font.bold: true
                        font.pixelSize: 25
                    }

                    Slider {
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
                        color: colors.primary_container

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "HIIIIIII"
                            color: colors.on_primary_container
                        }

                    }

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 220
                        height: 40
                        color: colors.primary_container

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "HIIIIIII"
                            color: colors.on_primary_container
                        }

                    }

                }

                RowLayout {
                    spacing: 20

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 220
                        height: 40
                        color: colors.primary_container

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "HIIIIIII"
                            color: colors.on_primary_container
                        }

                    }

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 220
                        height: 40
                        color: colors.primary_container

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            verticalAlignment: Text.AlignVCenter
                            text: "HIIIIIII"
                            color: colors.on_primary_container
                        }

                    }

                }

            }

        }

    }

}
