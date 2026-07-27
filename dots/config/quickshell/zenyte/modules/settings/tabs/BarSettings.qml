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
            type: "text",
            name: "Bar Height",
            desc: "Set the custom height of the bar in pixels",
            bind: () => Config.bar.height,
            width: 60,
            set: v => Config.bar.height = parseInt(v)
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
            type: "text",
            name: "Floating",
            desc: "Set the margins of bar when it is floating",
            bind: () => Config.bar.margins.floating,
            width: 60,
            set: v => Config.bar.margins.floating = parseInt(v)
        },
        {
            type: "text",
            name: "Popouts",
            desc: "Set the margins of bar poputs",
            bind: () => Config.bar.margins.popout,
            width: 60,
            set: v => Config.bar.margins.popout = parseInt(v)
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
        groupTitle: "Bar Settings"
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
