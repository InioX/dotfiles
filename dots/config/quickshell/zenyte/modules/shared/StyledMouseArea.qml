import QtQuick

MouseArea {
    property bool pointingCursor: true

    anchors.fill: parent
    hoverEnabled: true

    cursorShape: pointingCursor ? Qt.PointingHandCursor : Qt.Normal
}
