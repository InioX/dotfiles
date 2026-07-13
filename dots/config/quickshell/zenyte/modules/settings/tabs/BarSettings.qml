import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.modules.shared
import qs.modules.settings.tabs

ColumnLayout {
    id: root

    property int rowSpacing: 15

    spacing: 10

    TabHeader {
        text: "Basic Settings"
    }

    SettingsEntry {
        spacing: root.rowSpacing

        name: "Bottom"
        description: "Position the bar on the bottom if enabled"

        StyledSwitch {
            id: bottomBarSwitch
            checked: Config.bar.bottom

            onCheckedChanged: {
                Config.bar.bottom = checked;
            }
        }
    }

    SettingsEntry {
        spacing: root.rowSpacing

        name: "Full Width"
        description: "Make the bar take the full width on right and left sides"

        StyledSwitch {
            id: widthBarSwitch
            checked: Config.bar.full_width

            onCheckedChanged: {
                Config.bar.full_width = checked;
            }
        }
    }

    SettingsEntry {
        spacing: root.rowSpacing

        name: "Floating"
        description: "Make the bar float over windows as an overlay"

        StyledSwitch {
            id: floatingBarSwitch
            checked: Config.bar.floating

            onCheckedChanged: {
                Config.bar.floating = checked;
            }
        }
    }

    TabHeader {
        text: "Visibility"
    }

    SettingsEntry {
        spacing: root.rowSpacing

        name: "Show In Overview"
        description: "Make the bar show in Niri overview"

        StyledSwitch {
            id: overviewVisibleBarSwitch
            checked: Config.bar.visible.overview

            onCheckedChanged: {
                Config.bar.visible.overview = checked;
            }
        }
    }
}
