import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.shared

PanelWindow {
    implicitWidth: 500
    implicitHeight: 500

    color: "transparent"

    StyledRoundRect {
        anchors.centerIn: parent

        ColumnLayout {
            id: column

            spacing: 20
            anchors.margins: 20

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
                    list.currentIndex = filtered.values.length > 0 ? 0 : -1;
                }
            }

            StyledText {
                text: "Hello"

                color: Colors.md3.on_surface
                font.pixelSize: Config.style.font.size.small
            }

            StyledText {
                text: "World"

                color: Colors.md3.on_surface
                font.pixelSize: Config.style.font.size.small
            }

            StyledText {
                text: "ini"

                color: Colors.md3.on_surface
                font.pixelSize: Config.style.font.size.small
            }
        }

        RowLayout {
            id: bottomRow

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            spacing: 10
            anchors.margins: 20

            Item {
                Layout.fillWidth: true
            }

            StyledButton {
                buttonText: "Close"

                onClicked: {
                    States.isSettingsOpened = false;
                }
            }

            StyledButton {
                buttonText: "Save"
                normalColor: Colors.md3.primary_container
                highlightColor: Colors.getColorWithAlpha(Colors.md3.primary_container, 0.8)

                normalTextColor: Colors.md3.on_primary_container
                highlightTextColor: Colors.md3.on_primary_container

                onClicked: {
                    Config.saveConfig();
                }
            }
        }
    }
}
