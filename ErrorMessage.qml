import QtQuick

Row
{
    id: row

    property alias spacing: row.spacing
    property alias msgText: msg.text
    property alias msgFontSize:   msg.font.pixelSize
    property alias msgFontWeight: msg.font.weight
    property alias msgFontFamily: msg.font.family

    property int picSize: pic.width
    property url picSource: "resources/images/attention.svg"
    property color msgColor: "red"

    Image
    {
        id: pic
        source: picSource
        width:  picSize
        height: picSize
        anchors.verticalCenter: parent.verticalCenter
    }

    Text
    {
        id: msg
        color: msgColor
        verticalAlignment: Qt.AlignVCenter
    }
}
