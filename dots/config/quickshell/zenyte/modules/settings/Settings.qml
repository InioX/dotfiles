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

    implicitHeight: 600
    implicitWidth: 650

    minimumSize: "500x500"

    color: "transparent"

    title: "Zenyte Settings"

    property string settingsTab: "bar"

    StyledRoundRect {
        anchors.fill: parent

        ColumnLayout {
            id: column
            anchors.fill: parent

            spacing: 20
            anchors.margins: 20
            Layout.fillWidth: true

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            // StyledText {
            //     Layout.alignment: Qt.AlignHCenter
            //     text: root.title
            //     font.pixelSize: Config.style.font.size.medium
            //     color: Colors.md3.on_surface
            // }

            Rectangle {
                id: tabContainer
                implicitHeight: 40
                Layout.fillWidth: true
                color: Colors.md3.surface_container
                radius: Config.style.radius.widget
                clip: true

                property var activeTabItem: null

                Rectangle {
                    id: selectionIndicator
                    height: parent.height
                    color: Colors.md3.surface_container_highest
                    radius: tabContainer.radius

                    x: tabContainer.activeTabItem ? tabContainer.activeTabItem.x : 0
                    width: tabContainer.activeTabItem ? tabContainer.activeTabItem.width : 0

                    Behavior on x {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.OutCubic
                        }
                    }
                    Behavior on width {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.OutCubic
                        }
                    }
                }

                RowLayout {
                    id: tabSwitchRow
                    anchors.fill: parent
                    spacing: 0

                    readonly property var tabsModel: [
                        {
                            name: "Bar",
                            value: "bar"
                        },
                        {
                            name: "Style",
                            value: "style"
                        },
                        {
                            name: "Launcher",
                            value: "launcher"
                        },
                        {
                            name: "Desktop",
                            value: "desktop"
                        }
                    ]

                    Repeater {
                        model: tabSwitchRow.tabsModel

                        delegate: Item {
                            id: tabButton
                            implicitHeight: 40
                            Layout.fillWidth: true

                            readonly property bool isActive: root.settingsTab === modelData.value

                            onIsActiveChanged: {
                                if (isActive) {
                                    tabContainer.activeTabItem = tabButton;
                                }
                            }

                            Component.onCompleted: {
                                if (isActive) {
                                    tabContainer.activeTabItem = tabButton;
                                }
                            }

                            StyledText {
                                anchors.centerIn: parent
                                text: modelData.name
                                color: Colors.md3.on_surface
                                font.pixelSize: Config.style.font.size.small

                                Behavior on color {
                                    StyledColorAnimation {}
                                }
                            }

                            StyledMouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    root.settingsTab = modelData.value;
                                }
                            }
                        }
                    }
                }
            }

            ScrollView {
                id: settingsScrollView

                Layout.fillWidth: true
                Layout.fillHeight: true

                anchors.bottom: bottomBarPanel.top

                clip: true
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                ScrollBar.vertical.implicitWidth: 8

                rightPadding: 16

                contentHeight: (settingsTabLoader.item ? settingsTabLoader.item.implicitHeight : 0) + 70

                Loader {
                    id: settingsTabLoader

                    sourceComponent: {
                        if (root.settingsTab === "bar")
                            return barTabComponent;
                        if (root.settingsTab === "style")
                            return styleTabComponent;
                        return null;
                    }

                    width: settingsScrollView.availableWidth
                }
            }
        }

        Rectangle {
            id: bottomBarPanel

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: Config.style.borders.popout

            height: bottomRow.implicitHeight + 40
            color: Colors.md3.surface

            bottomLeftRadius: parent.radius
            bottomRightRadius: parent.radius

            RowLayout {
                id: bottomRow
                anchors.fill: parent
                anchors.margins: 20
                spacing: 10

                Item {
                    Layout.fillWidth: true
                }

                StyledButton {
                    buttonText: "Close"
                    onClicked: States.isSettingsOpened = false
                }

                StyledButton {
                    buttonText: "Save"
                    normalColor: Colors.md3.primary_container
                    highlightColor: Colors.getColorWithAlpha(Colors.md3.primary_container, 0.8)
                    normalTextColor: Colors.md3.on_primary_container
                    highlightTextColor: Colors.md3.on_primary_container
                    onClicked: Config.saveConfig()
                }
            }
        }
    }

    Component {
        id: barTabComponent
        BarSettings {}
    }

    Component {
        id: styleTabComponent
        StyleSettings {}
    }
}
