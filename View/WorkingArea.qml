import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Components"
import "Categories"

import App.auth

Item
{
    id: root
    MenuBar
    {
        id: menu
        width: Screen.width * 0.05
        model: ["Главная", "Сотрудники", "Настройки", "Выход"]

        z: 1
        anchors
        {
            left: parent.left
            bottom: parent.bottom
            top: parent.top
        }

        category.onCurrentChanged:
        {
            if(category.current === category.last) return

            switch(category.current)
            {
            case model[0]: // main
                stack.replace(cat_main)
                break;
            case model[1]: // employees
                stack.replace(cat_employees)
                break;
            case model[2]: // settings
                stack.replace(cat_settings)
                break;
            case model[3]: // exit
                popup.open()
                break;
            }
        }
    }

    StackView
    {
        id: stack
        anchors
        {
            left: menu.right
            right: parent.right
            bottom: parent.bottom
            top: parent.top
        }
    }

    Component
    {
        id: cat_main
        Main {}
    }

    Component
    {
        id: cat_employees
        Employees {}
    }


    PopupWindow
    {
        id: popup
        width: 500
        modal: true

        title: "Выход из учетной записи"
        text: "Вы собираетесь выйти из своей учетной записи. \nНесохраненные данные могут быть утеряны. \nВы уверены, что хотите продолжить?"
        font.pixelSize: 20

        colors.text: Theme.palette.text.primary
        colors.background: Theme.palette.background
        radius: 10
        border.width: 1
        colors.border: Theme.palette.border.primary

        anchors.centerIn: parent

        Overlay.modal: Rectangle
        {
            color: "black"
            opacity: 0.5
        }

        closePolicy: Popup.NoAutoClose

        onRejected:
        {
            popup.close()
            AuthManager.logoff()
        }

        onAccepted:
        {
            popup.close()
            menu.category.current = menu.category.last
        }

        btn_left_fillWidth: true
        btn_Cancel
        {
            colors.background_hovered: "#c10003"
            colors.background: "#e60000"
            text:            "Выйти"
            colors.text:     "white"
            font.bold:       true
            font.pixelSize:  14
            radius:          10
        }

        btn_Accept
        {
            colors.background_hovered: Theme.palette.border.hover
            colors.background: Theme.palette.surface
            colors.border: Theme.palette.border.primary
            colors.text:     Theme.palette.text.primary
            text:            "Отмена"
            font.bold:       true
            font.pixelSize:  14
            radius:          10
        }
    }
}
