import QtQuick

QtObject {
    property int streamId: -1
    property int sessionId: -1
    property string kind: "" // PipeWire or WlrScreencopy
    property string target: "" // Nothing, Output, Window
    property string outputName: ""
    property int windowId: -1
    property bool isDynamicTarget: false
    property bool isActive: false
    property int pid: -1
    property int pwNodeId: -1
}
