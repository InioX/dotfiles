// BarSettings.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.modules.shared
import qs.modules.settings.tabs

ColumnLayout {
    id: root
    spacing: 20

    property string searchQuery: ""

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.forceActiveFocus();
        }
    }

    readonly property var basicSettingsModel: [
        {
            type: "switch",
            name: "Bottom",
            desc: "Position the bar on the bottom if enabled",
            bind: () => Config.bar.bottom,
            set: v => Config.bar.bottom = v
        },
        {
            type: "switch",
            name: "Full Width",
            desc: "Make the bar take the full width on right and left sides",
            bind: () => Config.bar.full_width,
            set: v => Config.bar.full_width = v
        },
        {
            type: "switch",
            name: "Floating",
            desc: "Make the bar float over windows as an overlay",
            bind: () => Config.bar.floating,
            set: v => Config.bar.floating = v
        },
        {
            type: "slider",
            name: "Bar Height",
            desc: "Set the custom height of the bar in pixels",
            bind: () => Config.bar.height,
            min: 40,
            max: 100,
            step: 1,
            set: v => Config.bar.height = Math.round(v)
        }
    ]

    readonly property var visibilitySettingsModel: [
        {
            type: "switch",
            name: "Show In Overview",
            desc: "Make the bar show in Niri overview",
            bind: () => Config.bar.visible.overview,
            set: v => Config.bar.visible.overview = v
        },
        {
            type: "switch",
            name: "Show On Empty Workspaces",
            desc: "Make the bar show on workspaces with no tiled windows",
            bind: () => Config.bar.visible.empty_workspace,
            set: v => Config.bar.visible.empty_workspace = v
        },
        {
            type: "switch",
            name: "Show Always",
            desc: "Make the bar always show (will get hidden in fullscreen)",
            bind: () => Config.bar.visible.always,
            set: v => Config.bar.visible.always = v
        },
        {
            type: "switch",
            name: "Show On Top",
            desc: "Make the bar show on top of all windows like an overlay",
            bind: () => Config.bar.visible.on_top,
            set: v => Config.bar.visible.on_top = v
        }
    ]

    readonly property var marginsSettingsModel: [
        {
            type: "slider",
            name: "Floating",
            desc: "Set the margins of bar when it is floating",
            bind: () => Config.bar.margins.floating,
            min: 0,
            max: 100,
            step: 1,
            set: v => Config.bar.margins.floating = Math.round(v)
        },
        {
            type: "slider",
            name: "Popouts",
            desc: "Set the margins of bar poputs",
            bind: () => Config.bar.margins.popout,
            min: 0,
            max: 100,
            step: 1,
            set: v => Config.bar.margins.popout = Math.round(v)
        }
    ]

    SettingsGroup {
        groupTitle: "Bar Settings"
        modelData: root.basicSettingsModel
        searchQuery: root.searchQuery
    }

    SettingsGroup {
        groupTitle: "Visibility"
        modelData: root.visibilitySettingsModel
        searchQuery: root.searchQuery
    }

    SettingsGroup {
        groupTitle: "Margins"
        modelData: root.marginsSettingsModel
        searchQuery: root.searchQuery
    }
}
