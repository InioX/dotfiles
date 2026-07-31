// qmllint disable unqualified

import qs.services
import qs.services.niri
import qs.modules.shared
import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

Item {
    id: root

    required property ShellScreen screen
    property bool shouldHighlightBackground: workspaceMouseArea.containsMouse

    implicitHeight: 40
    // Dynamic width now hooks into the main workspace ListView's content width
    implicitWidth: mainWorkspaceList.contentWidth + (Config.bar.color_widget_background ? 40 : 20)

    StyledMouseArea {
        id: workspaceMouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    Rectangle {
        id: background
        anchors.fill: parent

        Behavior on color {
            StyledColorAnimation {}
        }

        color: shouldHighlightBackground ? (Config.bar.color_widget_background ? Colors.md3.surface_container_high : Colors.md3.surface_container) : (Config.bar.color_widget_background ? Colors.md3.surface_container : "transparent")
        radius: Config.style.rounding.small

        border.color: Colors.md3.outline_variant
        border.width: Config.style.borders.widget

        ListView {
            id: mainWorkspaceList
            anchors.centerIn: parent
            height: 30
            orientation: ListView.Horizontal
            interactive: false
            spacing: 6
            width: contentWidth

            model: [...Niri.workspaces.filter(item => item.output === root.screen.name)].sort((a, b) => a.idx - b.idx)

            displaced: Transition {
                NumberAnimation {
                    property: "x"
                    duration: 150
                    easing.type: Easing.OutQuad
                }
            }
            add: Transition {
                NumberAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                }
            }
            remove: Transition {
                NumberAnimation {
                    property: "opacity"
                    from: 1
                    to: 0
                }
            }

            delegate: Rectangle {
                id: wsDel

                required property NiriWorkspace modelData
                readonly property bool highlight: modelData?.isFocused

                height: 30

                width: {
                    if (iconList.count > 0) {
                        return iconList.contentWidth + 40;
                    }
                    return 0;
                }

                radius: Config.style.radius.widget

                scale: {
                    if (iconList.count === 0) {
                        return 0;
                    } else if (!highlight) {
                        return 0.9;
                    }
                    return 1;
                }

                Behavior on scale {
                    StyledSpringAnimation {}
                }

                color: highlight ? Colors.md3.surface_container_high : "transparent"

                RowLayout {
                    id: iconRowLayout
                    anchors.centerIn: parent
                    spacing: iconList.count > 0 ? 8 : 0

                    StyledText {
                        id: wsNum
                        text: wsDel.modelData.idx
                        color: wsDel.highlight ? Colors.md3.on_surface : Colors.md3.outline
                        Layout.alignment: Qt.AlignVCenter
                        font.pixelSize: Config.style.font.size.medium
                        font.bold: true
                    }

                    ListView {
                        id: iconList
                        orientation: ListView.Horizontal
                        interactive: false
                        spacing: 4

                        Layout.alignment: Qt.AlignVCenter
                        Layout.preferredHeight: 22

                        readonly property int iconSize: 20
                        Layout.preferredWidth: count > 0 ? (count * iconSize) + ((count - 1) * spacing) : 0

                        model: [...Niri.windows].filter(item => item.workspaceId === wsDel.modelData?.id).sort((a, b) => a.scrollingColumnIndex - b.scrollingColumnIndex)

                        delegate: Item {
                            width: iconList.iconSize
                            height: iconList.iconSize

                            IconImage {
                                id: imageIcon
                                anchors.fill: parent
                                source: Quickshell.iconPath(AppSearch.guessIcon(modelData.appId), "image-missing")

                                layer.enabled: wsDel.highlight
                                layer.smooth: true
                                Layout.alignment: Qt.AlignVCenter

                                layer.effect: MultiEffect {
                                    colorization: 1.0
                                    colorizationColor: Colors.md3.on_surface
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
