import QtQuick

Row
{
    property alias text: msg.text
    property alias font: msg.font

    property int picSize: pic.width
    property url picSource: "qrc:/qt/qml/Sable_CRM/Resources/images/attention.svg"
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
