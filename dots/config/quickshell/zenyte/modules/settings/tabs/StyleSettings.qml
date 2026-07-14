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

    readonly property var fontSizeSettingsModel: [
        {
            type: "text",
            name: "Small",
            desc: "Sets the custom height of the font in pixels",
            bind: () => Config.style.font.size.small,
            width: 60,
            set: v => Config.style.font.size.small = parseInt(v)
        },
        {
            type: "text",
            name: "Medium",
            desc: "Sets the custom height of the font in pixels",
            bind: () => Config.style.font.size.medium,
            width: 60,
            set: v => Config.style.font.size.medium = parseInt(v)
        },
        {
            type: "text",
            name: "Big",
            desc: "Sets the custom height of the font in pixels",
            bind: () => Config.style.font.size.big,
            width: 60,
            set: v => Config.style.font.size.big = parseInt(v)
        },
        {
            type: "text",
            name: "Icon",
            desc: "Sets the custom height of the font in pixels",
            bind: () => Config.style.font.size.icon,
            width: 60,
            set: v => Config.style.font.size.icon = parseInt(v)
        },
        {
            type: "text",
            name: "Icon Small",
            desc: "Sets the custom height of the font in pixels",
            bind: () => Config.style.font.size.icon_small,
            width: 60,
            set: v => Config.style.font.size.icon_small = parseInt(v)
        },
        {
            type: "text",
            name: "Icon Medium",
            desc: "Sets the custom height of the font in pixels",
            bind: () => Config.style.font.size.icon_medium,
            width: 60,
            set: v => Config.style.font.size.icon_medium = parseInt(v)
        },
    ]

    readonly property var borderSizeSettingsModel: [
        {
            type: "text",
            name: "Bar",
            desc: "Sets the border size of the bar in pixels",
            bind: () => Config.style.borders.bar.normal,
            width: 60,
            set: v => Config.style.borders.bar.normal = parseInt(v)
        },
        {
            type: "text",
            name: "Floating Bar",
            desc: "Sets the border size of the bar when floating in pixels",
            bind: () => Config.style.borders.bar.floating,
            width: 60,
            set: v => Config.style.borders.bar.floating = parseInt(v)
        },
        {
            type: "text",
            name: "Dock",
            desc: "Sets the border size of the dock in pixels",
            bind: () => Config.style.borders.dock.normal,
            width: 60,
            set: v => Config.style.borders.dock.normal = parseInt(v)
        },
        {
            type: "text",
            name: "Floating Dock",
            desc: "Sets the border size of the dock when floating in pixels",
            bind: () => Config.style.borders.dock.floating,
            width: 60,
            set: v => Config.style.borders.dock.floating = parseInt(v)
        },
        {
            type: "text",
            name: "Popouts",
            desc: "Sets the border size of popouts in pixels",
            bind: () => Config.style.borders.popout,
            width: 60,
            set: v => Config.style.borders.popout = parseInt(v)
        },
        {
            type: "text",
            name: "Widgets",
            desc: "Sets the border size of the widgets in pixels",
            bind: () => Config.style.borders.widget,
            width: 60,
            set: v => Config.style.borders.widget = parseInt(v)
        },
    ]

    readonly property var radiusSizeSettingsModel: [
        {
            type: "text",
            name: "Bar",
            desc: "Sets the radius of the bar in pixels",
            bind: () => Config.style.radius.bar.normal,
            width: 60,
            set: v => Config.style.radius.bar.normal = parseInt(v)
        },
        {
            type: "text",
            name: "Floating Bar",
            desc: "Sets the radius of the bar when floating in pixels",
            bind: () => Config.style.radius.bar.floating,
            width: 60,
            set: v => Config.style.radius.bar.floating = parseInt(v)
        },
        {
            type: "text",
            name: "Popouts",
            desc: "Sets the radius of popouts in pixels",
            bind: () => Config.style.radius.popout,
            width: 60,
            set: v => Config.style.radius.popout = parseInt(v)
        },
        {
            type: "text",
            name: "Widgets",
            desc: "Sets the radius of the widgets in pixels",
            bind: () => Config.style.radius.widget,
            width: 60,
            set: v => Config.style.radius.widget = parseInt(v)
        },
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
        groupTitle: "Font Size"
        modelData: root.fontSizeSettingsModel
    }

    SettingsGroup {
        groupTitle: "Border Size"
        modelData: root.borderSizeSettingsModel
    }

    SettingsGroup {
        groupTitle: "Radius Size"
        modelData: root.radiusSizeSettingsModel
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
