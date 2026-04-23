import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls

import "../../Components"

PopupWindow
{
    id: root
    anchors.centerIn: parent

    modal: true
    radius: 10

    implicitWidth: parent.width * 0.75
    implicitHeight: parent.height * 0.75

    title: "Добавить сотрудника"
    colors.border: Theme.palette.border.primary
    colors.background: Theme.palette.background
    colors.text: Theme.palette.text.primary
    border.width: 1

    contentItem: Item
    {
        ColumnLayout
        {
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            spacing: 10
            anchors.fill: parent
            Repeater
            {
                model:
                [
                    {
                        text: "ФИО:",
                        placeholder: "Введите полное имя",
                        action: function () {}
                    },
                    {
                        text: "Логин:",
                        placeholder: "Введите уникальный логин",
                        action: function () {}
                    },
                    {
                        text: "Пароль:",
                        placeholder: "Придумайте пароль",
                        action: function () {}
                    },
                    {
                        text: "Повторите пароль:",
                        placeholder: "Повторите пароль",
                        action: function () {}
                    }
                ]

                ColumnLayout
                {
                    Layout.fillWidth: true
                    Text
                    {
                        text: modelData.text
                        color: Theme.palette.text.primary
                        font.bold: true
                    }
                    LineEdit
                    {
                        Layout.fillWidth: true
                        Layout.minimumHeight: 40

                        colors.background: Theme.palette.surface
                        colors.border: Theme.palette.border.primary
                        radius: 10
                        placeholderText: modelData.placeholder
                    }
                }
            }

            Text
            {
                text: "Роль:"
                font.bold: true
                Layout.fillWidth: true
                color: Theme.palette.text.primary
            }

            ComboButton
            {
                id: cb
                Layout.fillWidth: true
                Layout.minimumHeight: 40
                currentIndex: 3
                textRole: "role"
                model:
                [
                    {
                        role: "Супер-пользователь",
                        color: "#EAB308"
                    },
                    {
                        role: "Администратор",
                        color: "#F43F5E"
                    },
                    {
                        role: "Менеджер",
                        color: "#06B6D4"
                    },
                    {
                        role: "Сотрудник",
                        color: "#22C55E"
                    }
                ]

                colors
                {
                    border: Theme.palette.border.primary
                    background: Theme.palette.surface
                    background_hovered: Theme.palette.background
                }

                radius: 10

                delegate: ItemDelegate
                {
                    property var rc: roleColor(Qt.color(modelData.color), Theme.current)
                    function roleColor(base, theme)
                    {
                        if (theme === "light")
                        {
                            return {
                                bg: Qt.rgba(base.r, base.g, base.b, 0.12),
                                text: Qt.darker(base, 1.4),
                                border: Qt.darker(base, 1.2),
                                hover: Qt.rgba(base.r, base.g, base.b, 0.3)
                            }
                        }
                        else
                        {
                            return {
                                bg: Qt.rgba(base.r, base.g, base.b, 0.2),
                                text: Qt.lighter(base, 1.3),
                                border: Qt.lighter(base, 1.1),
                                hover: Qt.rgba(base.r, base.g, base.b, 0.4)
                            }
                        }
                    }

                    contentItem: Text
                    {
                        text: modelData.role
                        color: rc.text
                        font.bold: true
                    }

                    background: Rectangle
                    {
                        color: parent.hovered ? rc.hover : rc.bg
                        border.color: rc.border
                        border.width: 1
                        radius: 25
                    }
                }
            }

            Item { Layout.fillHeight: true }
        }
    }

    btn_left_fillWidth: true
    onRejected: close()

    btn_Accept
    {
        id: acpt
        text: "Добавить"
        font.bold: true
        colors.background_gradient: Gradient
        {
            GradientStop { position: 0.0; color: acpt.hovered ? Theme.palette.gradient.start_hover : Theme.palette.gradient.start }
            GradientStop { position: 1.0; color: acpt.hovered ? Theme.palette.gradient.end_hover   : Theme.palette.gradient.end   }
        }
        colors.text: "white"
        radius: 10
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
    }
}
