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

    property string searchQuery: ""

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.forceActiveFocus();
        }
    }

    readonly property var appSettingsModel: [
        {
            name: "Default Editor",
            desc: "Select the editor used to open project folders",
            type: "combo",
            width: 160,
            bind: () => Config.launcher.editor_command,
            set: cmd => {
                Config.launcher.editor_command = cmd;
                Config.saveConfig();
            },
            options: [
                {
                    label: "Zed",
                    command: ["zeditor", "%path%"]
                },
                {
                    label: "Helix",
                    command: ["ghostty", "--command=hx %path%"]
                },
                {
                    label: "VS Code",
                    command: ["code", "%path%"]
                },
                {
                    label: "Neovim",
                    command: ["ghostty", "--command=nvim %path%"]
                }
            ]
        }
    ]

    SettingsGroup {
        groupTitle: "Default Apps"
        modelData: root.appSettingsModel
    }
}
