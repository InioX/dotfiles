import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell
import Quickshell.Services.UPower

Rectangle {
    property var device: UPower.displayDevice
    property int percentage: device.percentage * 100

    width: 90
    height: 40
    radius: root.cornerRadius
    color: colors.primary_container

    Row {
        anchors.centerIn: parent
        spacing: 10

        Item {
            width: 32
            height: 32

            Shape {
                anchors.fill: parent
                layer.enabled: true
                layer.samples: 4

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: colors.surface_container_highest
                    strokeWidth: 3
                    capStyle: ShapePath.RoundCap

                    PathAngleArc {
                        centerX: 16
                        centerY: 16
                        radiusX: 14
                        radiusY: 14
                        startAngle: -90
                        sweepAngle: 360
                    }

                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: percentage < 20 ? colors.error : colors.primary
                    strokeWidth: 3
                    capStyle: ShapePath.RoundCap

                    PathAngleArc {
                        centerX: 16
                        centerY: 16
                        radiusX: 14
                        radiusY: 14
                        startAngle: -90
                        sweepAngle: (360 * (percentage / 100))

                        Behavior on sweepAngle {
                            NumberAnimation {
                                duration: 800
                                easing.type: Easing.OutQuint
                            }

                        }

                    }

                }

            }

            Text {
                anchors.centerIn: parent
                font.pixelSize: 14
                color: colors.on_surface
                text: device.isCharging ? "󱐋" : (percentage < 20 ? "󰂃" : "󰁿")
            }

        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: percentage + "%"
            font.pixelSize: 14
            font.bold: true
            color: colors.on_surface
        }

    }

}
