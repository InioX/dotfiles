import QtQuick

QtObject {
    property int id: -1
    property string title: ""
    property string appId: ""
    property int pid: -1
    property int workspaceId: -1
    property bool isFocused: false
    property bool isFloating: false
    property bool isUrgent: false

    // Which Column in the scrolling Layout, and Tile index, is where in that Column
    property int scrollingColumnIndex: -1
    property int scrollingColumnTileIndex: -1

    // Size with Decoration
    property int tileWidth: -1
    property int tileHeight: -1

    // Size without Decoration
    property int windowWidth: -1
    property int windowHeight: -1

    property int windowOffsetInTileX: -1
    property int windowOffsetInTileY: -1

    property int focusTimeStampSeconds: -1
    property int focusTimeStampNanos: -1
}
