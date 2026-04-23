import QtQuick
import QtQuick.Layouts
import Theme

Item
{
    Rectangle
    {
        id: bg
        anchors.fill: parent
        color: Theme.palette.background
    }

    ColumnLayout
    {
        anchors.fill: parent
        anchors.topMargin: 20
        anchors.bottomMargin: 20

        spacing: 20
        Text
        {
            id: title
            text: "Главная"
            color: Theme.palette.text.primary
            Layout.minimumHeight: 50

            verticalAlignment: Text.AlignVCenter
            leftPadding: 40

            font.pixelSize: 30
            font.bold: true
        }

        Rectangle
        {
            id: line
            Layout.minimumHeight: 1
            Layout.maximumHeight: 1
            color: Theme.palette.border.primary
            Layout.fillWidth: true
        }

        Item { Layout.fillHeight: true }
    }
}
