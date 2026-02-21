import "../Services"
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland

Item {
    property string displayText
    property color textColor
    property int fontSize
    property bool isBold: true

    width: hiddenText.implicitWidth
    height: hiddenText.implicitHeight
    clip: true

    Text {
        id: hiddenText

        text: parent.displayText
        font.pixelSize: parent.fontSize
        font.bold: parent.isBold
        visible: false
    }

    Text {
        id: visualText

        text: parent.displayText
        color: parent.textColor
        font.pixelSize: parent.fontSize
        font.bold: parent.isBold
        width: parent.width
        elide: Text.ElideRight

        Behavior on text {
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation {
                        target: visualText
                        property: "opacity"
                        to: 0
                        duration: 150
                        easing.type: Easing.OutCubic
                    }

                    NumberAnimation {
                        target: visualText
                        property: "y"
                        to: -10
                        duration: 150
                        easing.type: Easing.OutCubic
                    }

                }

                PropertyAction {
                    target: visualText
                    property: "text"
                }

                PropertyAction {
                    target: visualText
                    property: "y"
                    value: 10
                }

                ParallelAnimation {
                    NumberAnimation {
                        target: visualText
                        property: "opacity"
                        to: 1
                        duration: 200
                        easing.type: Easing.OutBack
                    }

                    NumberAnimation {
                        target: visualText
                        property: "y"
                        to: 0
                        duration: 200
                        easing.type: Easing.OutBack
                    }

                }

            }

        }

    }

}
