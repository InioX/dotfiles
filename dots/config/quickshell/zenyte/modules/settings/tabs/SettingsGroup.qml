import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.modules.shared

ColumnLayout {
    id: groupRoot

    property string groupTitle: ""
    property var modelData: []

    property string searchQuery: ""

    readonly property var filteredModelData: {
        if (!searchQuery || searchQuery.trim() === "")
            return modelData;

        let query = searchQuery.toLowerCase().trim();
        return modelData.filter(item => {
            let matchName = item.name && item.name.toLowerCase().includes(query);
            let matchDesc = item.desc && item.desc.toLowerCase().includes(query);
            return matchName || matchDesc;
        });
    }

    visible: filteredModelData.length > 0
    Layout.fillWidth: true
    spacing: 8

    TabHeader {
        text: groupTitle
    }

    Repeater {
        model: groupRoot.filteredModelData

        delegate: ColumnLayout {
            id: entryLayout
            Layout.fillWidth: true
            spacing: 8

            SettingsEntry {
                Layout.fillWidth: true
                name: modelData.name
                description: modelData.desc

                Loader {
                    sourceComponent: {
                        if (modelData.type === "switch")
                            return switchComponent;
                        if (modelData.type === "text")
                            return textComponent;
                        if (modelData.type === "slider")
                            return sliderInputComponent;
                        return null;
                    }

                    property var setting: modelData
                    Layout.alignment: Qt.AlignRight
                }
            }

            Loader {
                active: modelData.type === "slider"
                sourceComponent: sliderComponent

                property var setting: modelData

                Layout.fillWidth: true
                Layout.topMargin: 2
            }
        }
    }

    Component {
        id: switchComponent
        StyledSwitch {
            inactiveTrackColor: Colors.getPopoutWidgetColor(Colors.md3.surface_container_high)

            checked: setting.bind()
            onCheckedChanged: setting.set(checked)
        }
    }

    Component {
        id: textComponent
        StyledTextField {
            backgroundColor: Colors.getPopoutWidgetColor(Colors.md3.surface_container)
            activeBackgroundColor: Colors.getPopoutWidgetColor(Colors.md3.surface_container_high)

            text: setting.bind().toString()
            placeholderText: "Enter value..."
            onEditingFinished: setting.set(text)

            implicitWidth: setting.width !== undefined ? setting.width : 150
        }
    }

    Component {
        id: sliderComponent
        StyledSlider {
            backgroundColor: Colors.getPopoutWidgetColor(Colors.md3.surface_container_high)

            value: setting.bind()
            from: setting.min !== undefined ? setting.min : 0
            to: setting.max !== undefined ? setting.max : 100
            stepSize: setting.step !== undefined ? setting.step : 1

            onMoved: setting.set(value)
        }
    }

    Component {
        id: sliderInputComponent
        StyledTextField {
            // TODO: Make sure floats dont have too many decimal places
            property real minVal: setting.min !== undefined ? setting.min : 0
            property real maxVal: setting.min !== undefined ? setting.max : 0

            backgroundColor: Colors.getPopoutWidgetColor(Colors.md3.surface_container)
            activeBackgroundColor: Colors.getPopoutWidgetColor(Colors.md3.surface_container_high)

            text: {
                let temp = (minVal == 0.0 && maxVal == 1.0) ? Math.round(setting.bind()) : setting.bind();
                temp.toString();
            }
            placeholderText: "Value"
            implicitWidth: Math.max(40, contentWidth + leftPadding + rightPadding)

            horizontalAlignment: TextInput.AlignHCenter

            onEditingFinished: {
                let val = parseFloat(text);
                if (!isNaN(val)) {
                    val = Math.max(minVal, Math.min(maxVal, val));
                    setting.set(val);

                    if (minVal == 0.0 && maxVal == 1.0) {
                        return text = val.toString();
                    }

                    text = Math.round(val).toString();
                } else {
                    text = Math.round(setting.bind()).toString();
                }
            }
        }
    }
}
