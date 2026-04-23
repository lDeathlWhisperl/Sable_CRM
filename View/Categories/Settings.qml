import QtQuick
import QtQuick.Layouts
import Theme

import "../Components"

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
            text: "Настройки"
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

        RowLayout
        {
            Layout.fillWidth: true
            Layout.leftMargin: 40
            Layout.rightMargin: 40

            Text
            {
                text: "Тема: "
                color: Theme.palette.text.primary
            }

            ComboButton
            {
                model: ["Светлая", "Темная"]

                onCurrentTextChanged:
                {
                    switch(currentText)
                    {
                    case model[0]:
                        Theme.current = "light"
                        break
                    case model[1]:
                        Theme.current = "dark"
                        break
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }
    }
}
