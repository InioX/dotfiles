// StyleSettings.qml
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

    readonly property var transparencyBlurEnabledSettingsModel: [
        {
            type: "slider",
            name: "Bar",
            desc: "Sets the transparency of the bar when blur is enabled",
            bind: () => Config.style.transparency.blur_enabled.bar,
            min: 0.1,
            max: 1.0,
            step: 0.05,
            set: v => Config.style.transparency.blur_enabled.bar = v
        },
        {
            type: "slider",
            name: "Bar",
            desc: "Sets the transparency of widgets when blur is enabled",
            bind: () => Config.style.transparency.blur_enabled.widget,
            min: 0.1,
            max: 1.0,
            step: 0.05,
            set: v => Config.style.transparency.blur_enabled.widget = v
        },
        {
            type: "slider",
            name: "Bar",
            desc: "Sets the transparency of the dock when blur is enabled",
            bind: () => Config.style.transparency.blur_enabled.dock,
            min: 0.1,
            max: 1.0,
            step: 0.05,
            set: v => Config.style.transparency.blur_enabled.dock = v
        },
        {
            type: "slider",
            name: "Bar",
            desc: "Sets the transparency of popouts when blur is enabled",
            bind: () => Config.style.transparency.blur_enabled.popout,
            min: 0.1,
            max: 1.0,
            step: 0.05,
            set: v => Config.style.transparency.blur_enabled.popout = v
        },
        {
            type: "slider",
            name: "Bar",
            desc: "Sets the transparency of widgets in popouts when blur is enabled",
            bind: () => Config.style.transparency.blur_enabled.popout_widget,
            min: 0.1,
            max: 1.0,
            step: 0.05,
            set: v => Config.style.transparency.blur_enabled.popout_widget = v
        },
    ]

    readonly property var transparencySettingsModel: [
        {
            type: "slider",
            name: "Bar",
            desc: "Sets the transparency of the bar when blur is not enabled",
            bind: () => Config.style.transparency.normal.bar,
            min: 0.1,
            max: 1.0,
            step: 0.05,
            set: v => Config.style.transparency.normal.bar = v
        },
        {
            type: "slider",
            name: "Dock",
            desc: "Sets the transparency of the dock when blur is not enabled",
            bind: () => Config.style.transparency.normal.dock,
            min: 0.1,
            max: 1.0,
            step: 0.05,
            set: v => Config.style.transparency.normal.dock = v
        },
        {
            type: "slider",
            name: "Bar",
            desc: "Sets the transparency of the popouts when blur is not enabled",
            bind: () => Config.style.transparency.normal.popout,
            min: 0.1,
            max: 1.0,
            step: 0.05,
            set: v => Config.style.transparency.normal.popout = v
        }
    ]

    readonly property var blurSettingsModel: [
        {
            type: "switch",
            name: "Bar",
            desc: "Enable blur for the bar",
            bind: () => Config.style.blur.bar,
            set: v => Config.style.blur.bar = v
        },
        {
            type: "switch",
            name: "Widgets",
            desc: "Enable blur for widgets",
            bind: () => Config.style.blur.widget,
            bind: () => Config.style.blur.widget,
            set: v => Config.style.blur.widget = v
        },
        {
            type: "switch",
            name: "Dock",
            desc: "Enable blur for the dock",
            bind: () => Config.style.blur.dock,
            set: v => Config.style.blur.dock = v
        },
        {
            type: "switch",
            name: "Popouts",
            desc: "Enable blur for popouts",
            bind: () => Config.style.blur.popout,
            set: v => Config.style.blur.popout = v
        }
    ]

    readonly property var fontSizeSettingsModel: [
        {
            type: "slider",
            name: "Small",
            desc: "Sets the custom height of the font in pixels",
            bind: () => Config.style.font.size.small,
            min: 8,
            max: 24,
            step: 1,
            set: v => Config.style.font.size.small = Math.round(v)
        },
        {
            type: "slider",
            name: "Medium",
            desc: "Sets the custom height of the font in pixels",
            bind: () => Config.style.font.size.medium,
            min: 10,
            max: 32,
            step: 1,
            set: v => Config.style.font.size.medium = Math.round(v)
        },
        {
            type: "slider",
            name: "Big",
            desc: "Sets the custom height of the font in pixels",
            bind: () => Config.style.font.size.big,
            min: 14,
            max: 48,
            step: 1,
            set: v => Config.style.font.size.big = Math.round(v)
        },
        {
            type: "slider",
            name: "Icon",
            desc: "Sets the custom height of the font in pixels",
            bind: () => Config.style.font.size.icon,
            min: 12,
            max: 48,
            step: 1,
            set: v => Config.style.font.size.icon = Math.round(v)
        },
        {
            type: "slider",
            name: "Icon Small",
            desc: "Sets the custom height of the font in pixels",
            bind: () => Config.style.font.size.icon_small,
            min: 8,
            max: 24,
            step: 1,
            set: v => Config.style.font.size.icon_small = Math.round(v)
        },
        {
            type: "slider",
            name: "Icon Medium",
            desc: "Sets the custom height of the font in pixels",
            bind: () => Config.style.font.size.icon_medium,
            min: 10,
            max: 32,
            step: 1,
            set: v => Config.style.font.size.icon_medium = Math.round(v)
        }
    ]

    readonly property var borderSizeSettingsModel: [
        {
            type: "slider",
            name: "Bar",
            desc: "Sets the border size of the bar in pixels",
            bind: () => Config.style.borders.bar.normal,
            min: 0,
            max: 10,
            step: 1,
            set: v => Config.style.borders.bar.normal = Math.round(v)
        },
        {
            type: "slider",
            name: "Floating Bar",
            desc: "Sets the border size of the bar when floating in pixels",
            bind: () => Config.style.borders.bar.floating,
            min: 0,
            max: 10,
            step: 1,
            set: v => Config.style.borders.bar.floating = Math.round(v)
        },
        {
            type: "slider",
            name: "Dock",
            desc: "Sets the border size of the dock in pixels",
            bind: () => Config.style.borders.dock.normal,
            min: 0,
            max: 10,
            step: 1,
            set: v => Config.style.borders.dock.normal = Math.round(v)
        },
        {
            type: "slider",
            name: "Floating Dock",
            desc: "Sets the border size of the dock when floating in pixels",
            bind: () => Config.style.borders.dock.floating,
            min: 0,
            max: 10,
            step: 1,
            set: v => Config.style.borders.dock.floating = Math.round(v)
        },
        {
            type: "slider",
            name: "Popouts",
            desc: "Sets the border size of popouts in pixels",
            bind: () => Config.style.borders.popout,
            min: 0,
            max: 10,
            step: 1,
            set: v => Config.style.borders.popout = Math.round(v)
        },
        {
            type: "slider",
            name: "Widgets",
            desc: "Sets the border size of the widgets in pixels",
            bind: () => Config.style.borders.widget,
            min: 0,
            max: 10,
            step: 1,
            set: v => Config.style.borders.widget = Math.round(v)
        }
    ]

    readonly property var radiusSizeSettingsModel: [
        {
            type: "slider",
            name: "Bar",
            desc: "Sets the radius of the bar in pixels",
            bind: () => Config.style.radius.bar.normal,
            min: 0,
            max: 30,
            step: 1,
            set: v => Config.style.radius.bar.normal = Math.round(v)
        },
        {
            type: "slider",
            name: "Floating Bar",
            desc: "Sets the radius of the bar when floating in pixels",
            bind: () => Config.style.radius.bar.floating,
            min: 0,
            max: 30,
            step: 1,
            set: v => Config.style.radius.bar.floating = Math.round(v)
        },
        {
            type: "slider",
            name: "Dock",
            desc: "Sets the radius of the dock in pixels",
            bind: () => Config.style.radius.dock.normal,
            min: 0,
            max: 30,
            step: 1,
            set: v => Config.style.radius.dock.normal = Math.round(v)
        },
        {
            type: "slider",
            name: "Floating Dock",
            desc: "Sets the radius of the dock when floating in pixels",
            bind: () => Config.style.radius.dock.floating,
            min: 0,
            max: 30,
            step: 1,
            set: v => Config.style.radius.dock.floating = Math.round(v)
        },
        {
            type: "slider",
            name: "Popouts",
            desc: "Sets the radius of popouts in pixels",
            bind: () => Config.style.radius.popout,
            min: 0,
            max: 30,
            step: 1,
            set: v => Config.style.radius.popout = Math.round(v)
        },
        {
            type: "slider",
            name: "Widgets",
            desc: "Sets the radius of the widgets in pixels",
            bind: () => Config.style.radius.widget,
            min: 0,
            max: 30,
            step: 1,
            set: v => Config.style.radius.widget = Math.round(v)
        }
    ]

    SettingsGroup {
        groupTitle: "Transparency (Blur Enabled)"
        modelData: root.transparencyBlurEnabledSettingsModel
        searchQuery: root.searchQuery
    }

    SettingsGroup {
        groupTitle: "Transparency"
        modelData: root.transparencySettingsModel
        searchQuery: root.searchQuery
    }

    SettingsGroup {
        groupTitle: "Blur"
        modelData: root.blurSettingsModel
        searchQuery: root.searchQuery
    }

    SettingsGroup {
        groupTitle: "Font Size"
        modelData: root.fontSizeSettingsModel
        searchQuery: root.searchQuery
    }

    SettingsGroup {
        groupTitle: "Border Size"
        modelData: root.borderSizeSettingsModel
        searchQuery: root.searchQuery
    }

    SettingsGroup {
        groupTitle: "Radius Size"
        modelData: root.radiusSizeSettingsModel
        searchQuery: root.searchQuery
    }
}
