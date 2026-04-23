import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "../Components"
import "../Structs"
import "Instruments"
import Theme

Item
{
    id: root

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

        RowLayout
        {
            id: title
            spacing: 10
            Layout.fillWidth: true

            Text
            {
                text: "Сотрудники"
                color: Theme.palette.text.primary

                verticalAlignment: Text.AlignVCenter
                leftPadding: 40

                font.pixelSize: 30
                font.bold: true
            }

            Item
            {
                Layout.fillWidth: true
                Layout.minimumWidth: 0
            }

            Repeater
            {
                model:
                [
                    {
                        text: "Добавить сотрудника",
                        action: function() { add_employee.open() }
                    },
                    {
                        text: "Добавить \nроль",
                        action: function() { add_role.open() }
                    }
                ]
                PushButton
                {
                    Layout.alignment: Qt.AlignVCenter
                    implicitHeight: 50
                    implicitWidth: 150
                    text: modelData.text
                    font.bold: true
                    font.pixelSize: 18
                    radius: 10

                    colors
                    {
                        text: "white"
                        border: Theme.palette.border.primary
                        background: Theme.palette.button.primary
                        background_hovered: Theme.palette.button.hover
                    }

                    onPressed: modelData.action()
                }
            }

            PushButton
            {
                Layout.alignment: Qt.AlignVCenter
                implicitHeight: 50
                implicitWidth: 150
                text: "Управление ролями"
                font.pixelSize: 18
                font.bold: true
                radius: 10

                colors
                {
                    border: Theme.palette.border.primary
                    background: Theme.palette.surface
                    background_hovered: Theme.palette.border.primary
                    text: Theme.palette.text.primary
                }
            }

            Item
            {
                width: 40
                Layout.minimumWidth: 40
            }
        }

        Rectangle
        {
            id: line
            height: 1
            color: Theme.palette.border.primary
            Layout.fillWidth: true
        }

        Rectangle
        {
            id: card_search
            height: column.implicitHeight + 40

            Layout.fillWidth: true
            Layout.leftMargin: 40
            Layout.rightMargin: 40


            color: Theme.palette.surface
            border.color: Theme.palette.border.primary
            radius: 10

            ColumnLayout
            {
                id: column
                anchors.fill: parent
                anchors.margins: 20
                spacing: 20

                Text
                {
                    text: "Поиск"
                    color: Theme.palette.text.primary
                    font.pixelSize: 20
                    font.weight: Font.Bold
                }

                Rectangle
                {
                    height: 1
                    color: Theme.palette.border.primary
                    Layout.fillWidth: true
                }

                RowLayout
                {
                    id: row
                    Layout.fillWidth: true

                    LineEdit
                    {
                        implicitHeight: 50
                        Layout.fillWidth: true
                        colors.border: Theme.palette.border.primary
                        colors.background: Theme.palette.surface

                        radius: 10
                        placeholderText: "Поиск по имени или логину"
                        font.pixelSize: 14
                    }
                }
            }
        }

        Rectangle
        {
            id: tag
            height: 1
            color: Theme.palette.border.primary
            Layout.fillWidth: true
            Layout.margins: 10
            Layout.leftMargin: 40
            Layout.rightMargin: 40

            Rectangle
            {
                color: bg.color
                anchors.fill: str
            }

            Text
            {
                id: str
                text: "Список сотрудников"
                color: Theme.palette.text.primary
                padding: 10

                anchors
                {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: 20
                }

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 20
                font.weight: Font.Bold
            }
        }

        Rectangle
        {
            id: card_employee
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: 40
            Layout.rightMargin: 40

            color: Theme.palette.surface
            border.color: Theme.palette.border.primary
            radius: 10

            Table
            {
                anchors.fill: parent
                headerModel: ["Имя", "Должность", "Роль", " "]
                anchors.margins: 20
            }
        }
    }

    AddEmployee
    {
        id: add_employee
    }

    AddRole
    {
        id: add_role
    }
}
