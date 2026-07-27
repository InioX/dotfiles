// dockSettings.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.modules.shared
import qs.modules.settings.tabs

ColumnLayout {
    id: root
    spacing: 20

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
            desc: "Position the dock on the bottom if enabled",
            bind: () => Config.dock.bottom,
            set: v => Config.dock.bottom = v
        },
        {
            type: "switch",
            name: "Full Width",
            desc: "Make the dock take the full width on right and left sides",
            bind: () => Config.dock.full_width,
            set: v => Config.dock.full_width = v
        },
        {
            type: "switch",
            name: "Floating",
            desc: "Make the dock float over windows as an overlay",
            bind: () => Config.dock.floating,
            set: v => Config.dock.floating = v
        },
        {
            type: "text",
            name: "Dock Height",
            desc: "Set the custom height of the dock in pixels",
            bind: () => Config.dock.height,
            width: 60,
            set: v => Config.dock.height = parseInt(v)
        }
    ]

    readonly property var visibilitySettingsModel: [
        {
            type: "switch",
            name: "Show In Overview",
            desc: "Make the dock show in Niri overview",
            bind: () => Config.dock.visible.overview,
            set: v => Config.dock.visible.overview = v
        },
        {
            type: "switch",
            name: "Show On Empty Workspaces",
            desc: "Make the dock show on workspaces with no tiled windows",
            bind: () => Config.dock.visible.empty_workspace,
            set: v => Config.dock.visible.empty_workspace = v
        },
        {
            type: "switch",
            name: "Show Always",
            desc: "Make the dock always show (will get hidden in fullscreen)",
            bind: () => Config.dock.visible.always,
            set: v => Config.dock.visible.always = v
        },
        {
            type: "switch",
            name: "Show On Top",
            desc: "Make the dock show on top of all windows like an overlay",
            bind: () => Config.dock.visible.on_top,
            set: v => Config.dock.visible.on_top = v
        }
    ]

    readonly property var marginsSettingsModel: [
        {
            type: "text",
            name: "Floating",
            desc: "Set the margins of dock when it is floating",
            bind: () => Config.dock.margins.floating,
            width: 60,
            set: v => Config.dock.margins.floating = parseInt(v)
        },
        {
            type: "text",
            name: "Popouts",
            desc: "Set the margins of dock poputs",
            bind: () => Config.dock.margins.popout,
            width: 60,
            set: v => Config.dock.margins.popout = parseInt(v)
        }
    ]

    readonly property var iconSettingsModel: [
        {
            type: "text",
            name: "Icon Size",
            desc: "Set the size of icons in pixels",
            bind: () => Config.dock.icons.size,
            width: 60,
            set: v => Config.dock.icons.size = parseInt(v)
        },
        {
            type: "switch",
            name: "Colorize Icons",
            desc: "Colorize the icons in dock",
            bind: () => Config.dock.icons.colorize,
            set: v => Config.dock.margins.colorize = v
        }
    ]

    component SettingsGroup: ColumnLayout {
        id: groupRoot

        property string groupTitle: ""
        property var modelData: []
        Layout.fillWidth: true
        spacing: 15

        TabHeader {
            text: groupTitle
        }

        Repeater {
            model: groupRoot.modelData

            delegate: SettingsEntry {
                name: modelData.name
                description: modelData.desc

                Loader {
                    sourceComponent: {
                        if (modelData.type === "switch")
                            return switchComponent;
                        if (modelData.type === "text")
                            return textComponent;
                        return null;
                    }

                    property var setting: modelData

                    Layout.alignment: Qt.AlignRight
                }
            }
        }
    }

    SettingsGroup {
        groupTitle: "Dock Settings"
        modelData: root.basicSettingsModel
    }

    SettingsGroup {
        groupTitle: "Visibility"
        modelData: root.visibilitySettingsModel
    }

    SettingsGroup {
        groupTitle: "Margins"
        modelData: root.marginsSettingsModel
    }

    SettingsGroup {
        groupTitle: "Icons"
        modelData: root.iconSettingsModel
    }

    Component {
        id: switchComponent
        StyledSwitch {
            checked: setting.bind()
            onCheckedChanged: setting.set(checked)
        }
    }

    Component {
        id: textComponent
        StyledTextField {
            text: setting.bind().toString()
            placeholderText: "Enter value..."
            onEditingFinished: setting.set(text)

            implicitWidth: setting.width !== undefined ? setting.width : 150
        }
    }
}
