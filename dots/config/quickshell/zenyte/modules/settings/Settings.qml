import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
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

    StyledRoundRect {
        anchors.fill: parent

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                Layout.fillWidth: true
                height: 40

                color: Colors.md3.surface_container
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

                        color: closeButtonMouseArea.containsMouse ? Colors.md3.surface_container_high : "transparent"
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
                Layout.margins: 20
                spacing: 20

                Item {
                    implicitWidth: 60
                    Layout.fillHeight: true

                    StyledFabButton {
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
                                    color: isActive ? Colors.md3.primary_container : "transparent"

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
                                        color: tabDelegate.isActive ? Colors.md3.on_primary_container : Colors.md3.on_surface_variant
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

                ScrollView {
                    id: settingsScrollView

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

                        sourceComponent: {
                            if (root.settingsTab === "bar")
                                return barTabComponent;
                            if (root.settingsTab === "dock")
                                return dockTabComponent;
                            if (root.settingsTab === "style")
                                return styleTabComponent;
                            return null;
                        }

                        width: settingsScrollView.availableWidth
                    }
                }
            }
        }
    }

    Component {
        id: barTabComponent
        BarSettings {}
    }

    Component {
        id: dockTabComponent
        DockSettings {}
    }

    Component {
        id: styleTabComponent
        StyleSettings {}
    }
}
