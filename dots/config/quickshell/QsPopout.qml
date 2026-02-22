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
    implicitWidth: 600
    implicitHeight: 400
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
            anchors.fill: parent

            RowLayout {
                Rectangle {
                    id: wifiButton

                    property string ssid: "Searching..."

                    height: 30
                    width: 250
                    color: colors.primary_container

                    Text {
                        id: wifiText

                        text: "   " + wifiButton.ssid
                        font.pixelSize: 25
                        color: colors.on_primary_container
                    }

                    Process {
                        id: wifiProcess

                        command: ["nmcli", "-t", "-f", "ACTIVE,SSID", "dev", "wifi"]
                        running: true

                        stdout: SplitParser {
                            onRead: (line) => {
                                if (line.startsWith("yes:")) {
                                    let parts = line.split(":");
                                    if (parts.length > 1)
                                        wifiButton.ssid = parts[1];

                                } else if (line === "") {
                                    wifiButton.ssid = "Disconnected";
                                }
                            }
                        }

                    }

                    Timer {
                        id: restartTimer

                        interval: 2000
                        onTriggered: wifiProcess.running = true
                    }

                }

            }

        }

    }

}
