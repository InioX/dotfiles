import QtQuick

MouseArea {
    property bool pointingCursor: true

    hoverEnabled: true

    cursorShape: pointingCursor ? Qt.PointingHandCursor : Qt.Normal
}
