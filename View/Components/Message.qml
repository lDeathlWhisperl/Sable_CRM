import QtQuick

Row
{
    id: root
    property alias text: msg.text
    property alias font: msg.font

    property int picSize: pic.width
    property url picSource
    property color color
    spacing: 5

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
        color: root.color
        verticalAlignment: Qt.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}
