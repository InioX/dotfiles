// qmllint disable uncreatable-type
import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Wayland
import qs.services

Scope {
    // PanelWindow {
    //     id: top
    //     implicitHeight: border.borderWidth
    //     color: border.borderColor
    //     anchors {
    //         top: true
    //         left: true
    //         right: true
    //     }
    // }
    // PanelWindow {
    //     id: left
    //     implicitWidth: border.borderWidth
    //     color: border.borderColor
    //     anchors {
    //         top: true
    //         left: true
    //         bottom: true
    //     }
    // }
    // PanelWindow {
    //     id: bottom
    //     implicitHeight: border.borderWidth
    //     color: border.borderColor
    //     anchors {
    //         bottom: true
    //         left: true
    //         right: true
    //     }
    // }
    // PanelWindow {
    //     id: right
    //     implicitWidth: border.borderWidth
    //     color: border.borderColor
    //     anchors {
    //         top: true
    //         right: true
    //         bottom: true
    //     }
    // }

    id: border

    property int borderWidth: 10
    property color borderColor: Colors.md3.surface
    // property int cornerRadius: Config.bar.popout_radius
    property int cornerRadius: 30

    PanelWindow {
        id: topLeftCorner
        visible: !Config.bar.bottom && Config.bar.full_width

        implicitHeight: border.cornerRadius
        implicitWidth: border.cornerRadius
        color: "transparent"

        WlrLayershell.layer: WlrLayer.Overlay

        anchors {
            top: true
            left: true
        }

        Rectangle {
            Shape {
                anchors.fill: parent
                preferredRendererType: Shape.CurveRenderer

                ShapePath {
                    strokeWidth: 0
                    fillColor: border.borderColor
                    startX: 0
                    startY: border.cornerRadius

                    PathArc {
                        x: border.cornerRadius
                        y: 0
                        radiusX: border.cornerRadius
                        radiusY: border.cornerRadius
                        direction: PathArc.Clockwise
                    }

                    PathLine {
                        x: 0
                        y: 0
                    }

                    PathLine {
                        x: 0
                        y: border.cornerRadius
                    }
                }
            }
        }
    }

    PanelWindow {
        id: topRightCorner
        visible: !Config.bar.bottom && Config.bar.full_width

        implicitHeight: border.cornerRadius
        implicitWidth: border.cornerRadius
        color: "transparent"

        anchors {
            top: true
            right: true
        }

        Rectangle {
            Shape {
                anchors.fill: parent
                preferredRendererType: Shape.CurveRenderer

                ShapePath {
                    strokeWidth: 0
                    fillColor: border.borderColor
                    startX: 0
                    startY: 0

                    PathArc {
                        x: border.cornerRadius
                        y: border.cornerRadius
                        radiusX: border.cornerRadius
                        radiusY: border.cornerRadius
                        direction: PathArc.Clockwise
                    }

                    PathLine {
                        x: border.cornerRadius
                        y: 0
                    }

                    PathLine {
                        x: 0
                        y: 0
                    }
                }
            }
        }
    }

    PanelWindow {
        id: bottomLeftCorner
        visible: Config.bar.bottom && Config.bar.full_width

        implicitHeight: border.cornerRadius
        implicitWidth: border.cornerRadius
        color: "transparent"

        anchors {
            bottom: true
            left: true
        }

        Rectangle {
            Shape {
                anchors.fill: parent
                preferredRendererType: Shape.CurveRenderer

                ShapePath {
                    strokeWidth: 0
                    fillColor: border.borderColor
                    startX: border.cornerRadius
                    startY: border.cornerRadius

                    PathArc {
                        x: 0
                        y: 0
                        radiusX: border.cornerRadius
                        radiusY: border.cornerRadius
                        direction: PathArc.Clockwise
                    }

                    PathLine {
                        x: 0
                        y: border.cornerRadius
                    }

                    PathLine {
                        x: border.cornerRadius
                        y: border.cornerRadius
                    }
                }
            }
        }
    }

    PanelWindow {
        id: bottomRightCorner
        visible: Config.bar.bottom && Config.bar.full_width

        implicitHeight: border.cornerRadius
        implicitWidth: border.cornerRadius
        color: "transparent"

        anchors {
            bottom: true
            right: true
        }

        Rectangle {
            Shape {
                anchors.fill: parent
                preferredRendererType: Shape.CurveRenderer

                ShapePath {
                    strokeWidth: 0
                    fillColor: border.borderColor
                    startX: 0
                    startY: border.cornerRadius

                    PathLine {
                        x: border.cornerRadius
                        y: border.cornerRadius
                    }

                    PathLine {
                        x: border.cornerRadius
                        y: 0
                    }

                    PathArc {
                        x: 0
                        y: border.cornerRadius
                        radiusX: border.cornerRadius
                        radiusY: border.cornerRadius
                        direction: PathArc.Clockwise
                    }
                }
            }
        }
    }
}
