import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls
import Qt.labs.qmlmodels
import Theme

import "../../Components"

PopupWindow
{
    id: root
    anchors.centerIn: parent

    modal: true
    radius: 10

    implicitWidth: parent.width * 0.75
    implicitHeight: parent.height * 0.75

    title: "Добавление новой роли"

    property color chosen_role_color: Theme.palette.text.primary
    property string chosen_role_name: default_preview
    readonly property string default_preview: "Название роли"

    colors
    {
        text: Theme.palette.text.primary
        border: Theme.palette.border.primary
        background: Theme.palette.background
        border_hovered: Theme.palette.border.hover
    }

    contentItem: Item
    {
        RowLayout
        {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 20
            ColumnLayout
            {
                spacing: 50
                ColumnLayout
                {
                    spacing: 10
                    Text
                    {
                        Layout.fillWidth: true
                        text: "Название роли"
                        color: root.colors.text
                        font.bold: true
                    }
                    LineEdit
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        colors
                        {
                            background: Theme.palette.surface
                            text: root.colors.text
                            border: Theme.palette.border.primary
                        }
                        radius: 10
                        placeholderText: "Введите название роли"
                        maximumLength: 25

                        onEditingFinished:
                        {
                            chosen_role_name = inputText
                            if(chosen_role_name === "") chosen_role_name = default_preview
                        }

                        Text
                        {
                            text: parent.inputText.length + "/25"
                            color: root.colors.text
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            font.bold: true
                            font.pixelSize: 14
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                }

                ColumnLayout
                {
                    spacing: 10
                    Text
                    {
                        Layout.fillWidth: true
                        text: "Цвет тега"
                        color: root.colors.text
                        font.bold: true
                    }
                    RowLayout
                    {
                        id: r
                        Layout.fillWidth: true
                        spacing: 5

                        property int selectedIndex: -1
                        Repeater
                        {
                            model: ["#7258fe", "#449bfe", "#34cce8", "#62d15e", "#fec62d", "#fe9239", "#ef4c64", "#e74fc0", "#d2d5de", "transparent",]
                            PushButton
                            {
                                Layout.preferredWidth: 40
                                Layout.preferredHeight: 40
                                radius: 25
                                colors.background: hovered ? Qt.darker(modelData, 1.1) : modelData
                                colors.border: Theme.palette.surface
                                checkable: true
                                checked: index === r.selectedIndex
                                ToolTip.visible: hovered
                                ToolTip.text: modelData === "transparent" ? "Без фона" : modelData
                                onClicked:
                                {
                                    r.selectedIndex = index
                                    chosen_role_color = modelData
                                    le_color.clear()
                                }

                                Image
                                {
                                    visible: parent.checked
                                    anchors.centerIn: parent
                                    width: parent.width
                                    height: parent.height
                                    source: Theme.palette.icon.check
                                }
                            }
                        }

                        LineEdit
                        {
                            id: le_color
                            Layout.fillWidth: true
                            Layout.preferredHeight: 40
                            colors
                            {
                                background: Theme.palette.surface
                                text: root.colors.text
                                border: Theme.palette.border.primary
                            }
                            radius: 10
                            placeholderText: "#RRGGBB"

                            onEditingFinished:
                            {
                                chosen_role_color = inputText
                            }
                        }
                    }
                }

                ColumnLayout
                {
                    spacing: 10
                    Text
                    {
                        Layout.fillWidth: true
                        text: "Настройка доступов"
                        color: root.colors.text
                        font.bold: true
                    }
                    Text
                    {
                        Layout.fillWidth: true
                        text: "Укажите, какие возможности будут доступны для этой роли"
                        color: root.colors.text
                        font.pixelSize: 13
                    }
                }

                Table
                {
                    id: table
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    headerModel: ["Запрещено", "Просмотр", "Изменение"]
                    rowsModel: ["Пользователи", "Роли", "Клиенты", "Заказы", "Задачи"]

                    model: TableModel
                    {
                        id: userTable
                        TableModelColumn { display: "forbidden" }
                        TableModelColumn { display: "read"      }
                        TableModelColumn { display: "edit"      }
                        rows:
                        [
                            { forbidden: 1, read: 0, edit: 0 },
                            { forbidden: 1, read: 0, edit: 0 },
                            { forbidden: 1, read: 0, edit: 0 },
                            { forbidden: 1, read: 0, edit: 0 },
                            { forbidden: 1, read: 0, edit: 0 }
                        ]
                    }

                    property var rowGroups: []

                    Component.onCompleted:
                    {
                        rowGroups = new Array(rowsModel.length)
                        for (let i = 0; i < rowGroups.length; i++)
                            rowGroups[i] = Qt.createQmlObject('import QtQuick.Controls; ButtonGroup {}', table)
                    }

                    delegate: Item
                    {
                        CheckButton
                        {
                            anchors.centerIn: parent
                            checked: model.display
                            ButtonGroup.group: table.rowGroups[row]
                        }

                        Rectangle
                        {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            height: 1
                            color: root.colors.border
                        }
                    }
                }

                Message
                {
                    text: "Эти настройки можно будет изменить позже"
                    color: root.colors.text
                    picSource: Theme.palette.icon.info
                    picSize: 25
                    font.pixelSize: 13
                }
            }

            Rectangle
            {
                Layout.fillHeight: true
                Layout.preferredWidth: root.width / 3
                color: Theme.palette.surface
                border.color: root.colors.border
                radius: 10

                ColumnLayout
                {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 15

                    ColumnLayout
                    {
                        spacing: 10
                        Text
                        {
                            Layout.fillWidth: true
                            text: "Предпросмотр"
                            color: root.colors.text
                            font.bold: true
                        }
                        Text
                        {
                            Layout.fillWidth: true
                            text: "Так будет выглядеть тег с этой ролью"
                            color: root.colors.text
                            font.pixelSize: 13
                        }
                    }

                    RoleTag
                    {
                        id: tag

                        name: chosen_role_name
                        tag_color: chosen_role_color
                    }

                    UserCard
                    {
                        Layout.fillWidth: true
                        Layout.preferredHeight: parent.height * 0.75
                        colors.background: Theme.palette.background
                        colors.border: Theme.palette.border.primary

                        user
                        {
                            name: "Илья"
                            role_name: tag.name
                            role_color: tag.tag_color
                            phone: "89112568335"
                        }
                    }
                }
            }
        }
    }

    closePolicy: Popup.NoAutoClose
    btn_left_fillWidth: true
    btn_Accept
    {
        id: acpt
        text: "Создать"
        font.bold: true
        colors.background_gradient: Gradient
        {
            GradientStop { position: 0.0; color: acpt.hovered ? Theme.palette.gradient.start_hover : Theme.palette.gradient.start }
            GradientStop { position: 1.0; color: acpt.hovered ? Theme.palette.gradient.end_hover   : Theme.palette.gradient.end   }
        }
        colors.text: "white"
        radius: 10

        onReleased:
        {

        }
    }

    btn_Cancel
    {
        text: "Отмена"
        font.bold: true
        radius: 10

        colors
        {
            border: Theme.palette.border.primary
            text: Theme.palette.text.primary
            background: Theme.palette.surface
            background_hovered: Theme.palette.border.primary
        }

        onReleased: close()
    }
}
