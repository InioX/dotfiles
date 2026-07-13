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

            StyledSearch {
                id: searchBar

                placeHolderString: {
                    if (root.currentTab) {
                        return "Type to search " + root.currentTab;
                    } else {
                        return "Type to search";
                    }
                }

                onTextChanged: {
                    root.query = searchBar.text;
                    // list.currentIndex = filtered.values.length > 0 ? 0 : -1;
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

                contentHeight: (barSettingsLoader.item ? barSettingsLoader.item.implicitHeight : 0) + 70

                Loader {
                    id: barSettingsLoader
                    active: root.settingsTab === "bar"
                    sourceComponent: BarSettings {}

                    width: settingsScrollView.availableWidth
                }
            }
        }

        Rectangle {
            id: edgeGradient
            anchors.bottom: bottomBarPanel.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 15
            z: 2

            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "transparent"
                }
                GradientStop {
                    position: 1.0
                    color: Colors.md3.surface
                }
            }
        }

        Rectangle {
            id: bottomBarPanel
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: bottomRow.implicitHeight + 40
            color: Colors.md3.surface

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
}
