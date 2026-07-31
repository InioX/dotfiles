import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import qs.services
import qs.modules.shared
import qs.modules.settings.tabs

FloatingWindow {
    id: root

    property string query: ""

    implicitWidth: 800
    implicitHeight: 700

    minimumSize: "800x700"

    color: "transparent"

    title: "Zenyte Settings"

    property string settingsTab: "bar"

    BackgroundEffect.blurRegion: Config.style.blur.popout ? blurRegionDefinition : null

    Region {
        id: blurRegionDefinition
        item: !Compositors.isHyprland ? rect : null
        radius: rect.radius
    }

    StyledRoundRect {
        id: rect

        anchors.fill: parent

        radius: Config.style.radius.popout

        color: Colors.getPopoutWidgetColor(Colors.md3.surface_container_low)

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                Layout.fillWidth: true
                height: 40

                color: "transparent"

                topLeftRadius: parent.parent.radius !== undefined ? parent.parent.radius : 0
                topRightRadius: parent.parent.radius !== undefined ? parent.parent.radius : 0

                RowLayout {
                    anchors.fill: parent
                    spacing: 0

                    Item {
                        Layout.fillWidth: true
                    }

                    Rectangle {
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 40
                        Layout.rightMargin: 4

                        color: closeButtonMouseArea.containsMouse ? Colors.getPopoutWidgetColor(Colors.md3.surface_container_high) : "transparent"
                        radius: Config.style.radius.widget

                        StyledText {
                            anchors.centerIn: parent

                            text: "󰅖"
                            color: Colors.md3.on_surface
                            font.pixelSize: Config.style.font.size.icon_medium
                        }

                        StyledMouseArea {
                            id: closeButtonMouseArea

                            anchors.fill: parent
                            onClicked: States.isSettingsOpened = false
                        }
                    }
                }
            }

            RowLayout {
                id: mainBody
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.leftMargin: 20
                Layout.rightMargin: 20
                Layout.bottomMargin: 20
                spacing: 20

                Rectangle {
                    implicitWidth: 50
                    Layout.fillHeight: true
                    radius: Config.style.radius.popout

                    color: "transparent"

                    StyledFabButton {
                        id: fab
                        anchors.horizontalCenter: parent.horizontalCenter

                        buttonIcon: "󰠘"
                        normalColor: Colors.md3.primary_container
                        highlightColor: Colors.getColorWithAlpha(Colors.md3.primary_container, 0.8)
                        normalTextColor: Colors.md3.on_primary_container
                        highlightTextColor: Colors.md3.on_primary_container
                        onClicked: Config.saveConfig()
                    }

                    ListView {
                        width: parent.width
                        height: contentHeight

                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 24

                        readonly property var tabsModel: [
                            {
                                name: "Bar",
                                value: "bar",
                                icon: "󱔓"
                            },
                            {
                                name: "Dock",
                                value: "dock",
                                icon: "󰠷"
                            },
                            {
                                name: "Style",
                                value: "style",
                                icon: ""
                            },
                            {
                                name: "Desktop",
                                value: "desktop",
                                icon: "󰍹"
                            },
                            {
                                name: "General",
                                value: "general",
                                icon: "󰒓"
                            },
                            {
                                name: "Recording",
                                value: "recording",
                                icon: "󰻃"
                            }
                        ]

                        model: tabsModel
                        delegate: Rectangle {
                            id: tabDelegate
                            readonly property bool isActive: root.settingsTab === modelData.value

                            width: parent.width
                            height: 40
                            color: "transparent"

                            Column {
                                anchors.centerIn: parent
                                spacing: 4

                                Rectangle {
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    height: tabIcon.height + 4
                                    width: tabDelegate.isActive ? tabDelegate.width : tabDelegate.width * 0.7

                                    radius: Config.style.radius.widget
                                    color: isActive ? Colors.md3.secondary_container : "transparent"

                                    Behavior on color {
                                        StyledColorAnimation {
                                            easing.type: Easing.OutCubic
                                        }
                                    }

                                    Behavior on width {
                                        StyledSpringAnimation {}
                                    }

                                    StyledText {
                                        id: tabIcon
                                        anchors.centerIn: parent
                                        text: modelData.icon
                                        color: tabDelegate.isActive ? Colors.md3.on_secondary_container : Colors.md3.on_surface_variant
                                        font.pixelSize: Config.style.font.size.icon_small
                                    }
                                }

                                StyledText {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: modelData.name
                                    color: Colors.md3.on_surface_variant
                                    font.pixelSize: Config.style.font.size.smallest
                                }
                            }

                            StyledMouseArea {
                                anchors.fill: parent
                                onClicked: root.settingsTab = modelData.value
                            }
                        }
                    }
                }

                // Rectangle {
                //     Layout.fillHeight: true

                //     width: 1
                //     color: Colors.md3.outline_variant
                // }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: Colors.getPopoutWidgetColor(Colors.md3.surface)

                    radius: Config.style.radius.popout

                    ColumnLayout {
                        id: settingsScrollView

                        anchors.fill: parent
                        anchors.margins: 20

                        StyledSearch {
                            id: searchInput
                            Layout.bottomMargin: 10
                            color: Colors.getPopoutWidgetColor(Colors.md3.surface_container)
                        }

                        ScrollView {
                            id: mainScrollView

                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            clip: true
                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                            ScrollBar.vertical.implicitWidth: 8

                            rightPadding: 16

                            contentHeight: (settingsTabLoader.item ? settingsTabLoader.item.implicitHeight : 0) + 20

                            Loader {
                                id: settingsTabLoader

                                width: mainScrollView.availableWidth

                                sourceComponent: {
                                    if (root.settingsTab === "bar")
                                        return barTabComponent;
                                    if (root.settingsTab === "dock")
                                        return dockTabComponent;
                                    if (root.settingsTab === "style")
                                        return styleTabComponent;
                                    return null;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Component {
        id: barTabComponent
        BarSettings {
            searchQuery: searchInput.text
        }
    }

    Component {
        id: dockTabComponent
        DockSettings {
            searchQuery: searchInput.text
        }
    }

    Component {
        id: styleTabComponent
        StyleSettings {
            searchQuery: searchInput.text
        }
    }
}
