import qs.services
import qs.modules.shared
import QtQuick
import QtQuick.Layouts
import Quickshell

RowLayout {
    id: root
    spacing: 4

    property string query: ""
    property var pinnedAppIds: Config.launcher.pinned_apps

    function isAppPinned(appId) {
        return pinnedAppIds.indexOf(appId) !== -1;
    }

    function togglePin(appId) {
        let pins = Config.launcher.pinned_apps;

        Config.launcher.pinned_apps = pins.includes(appId) ? pins.filter(id => id !== appId) : [...pins, appId];

        Config.saveConfig();
    }

    ScriptModel {
        id: filtered
        values: {
            const pinTracker = root.pinnedAppIds;
            let allEntries = [...DesktopEntries.applications.values];
            const q = root.query.trim().toLowerCase();

            if (q !== "") {
                allEntries = allEntries.filter(d => d.name && d.name.toLowerCase().includes(q));
            }

            allEntries.sort((a, b) => {
                let aPinned = root.isAppPinned(a.id);
                let bPinned = root.isAppPinned(b.id);

                if (aPinned === bPinned) {
                    return a.name.localeCompare(b.name);
                }
                return aPinned ? -1 : 1;
            });

            return allEntries;
        }
    }

    StyledText {
        text: ":"
    }

    StyledTextInput {
        text: root.query
        onTextChanged: root.query = text
        focus: true
        Component.onCompleted: forceActiveFocus()

        Keys.onEscapePressed: States.showLauncher = false

        Keys.onPressed: event => {
            const ctrl = event.modifiers & Qt.ControlModifier;
            const alt = event.modifiers & Qt.AltModifier;
            if (event.key == Qt.Key_Left || event.key == Qt.Key_P && ctrl || event.key == Qt.Key_Tab) {
                event.accepted = true;
                if (list.currentIndex > 0)
                    list.currentIndex--;
            } else if (event.key == Qt.Key_Right || event.key == Qt.Key_N && ctrl || event.key == Qt.Key_Tab && ctrl) {
                event.accepted = true;
                if (list.currentIndex < list.count - 1)
                    list.currentIndex++;
            } else if ([Qt.Key_Return, Qt.Key_Enter].includes(event.key) && ctrl) {
                event.accepted = true;

                if (list.currentItem && list.currentItem.modelData) {
                    root.togglePin(list.currentItem.modelData.id);
                }
            } else if ([Qt.Key_Return, Qt.Key_Enter].includes(event.key)) {
                event.accepted = true;

                list.currentItem.modelData.execute();
                States.showLauncher = false;
            } else if (event.key == Qt.Key_C && ctrl) {
                event.accepted = true;
                States.showLauncher = false;
            }
        }
    }

    ListView {
        id: list

        model: filtered.values
        currentIndex: filtered.values.length > 0 ? 0 : -1

        orientation: ListView.Horizontal
        keyNavigationEnabled: false
        highlightMoveDuration: 0

        Layout.fillWidth: true
        Layout.fillHeight: true

        highlight: Rectangle {
            color: Colors.md3.primary
        }

        delegate: StyledText {
            id: listDelegate

            leftPadding: 8
            rightPadding: 8

            height: ListView.view.height

            required property var modelData
            required property int index
            property bool focused: list.currentIndex == index
            property bool isPinned: root.isAppPinned(modelData.id)

            property string pinIcon: isPinned ? "󰐃 " : ""

            text: pinIcon + modelData.name
            color: listDelegate.focused ? Colors.md3.on_primary : Colors.md3.on_surface
        }
    }
}
