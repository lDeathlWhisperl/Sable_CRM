import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

import "Components"
import Theme

import App.auth

Popup
{
    id: root
    width: 610
    height: 725

    property color le_bgColor: Theme.palette.surface
    property color le_bgColor_disabled: Theme.palette.text.alter
    property color le_borderColor: Theme.palette.border.primary
    property color le_borderColor_hovered: Theme.palette.gradient.start

    modal: true
    closePolicy: Popup.NoAutoClose

    FontLoader { source: "qrc:/qt/qml/Sable_CRM/Resources/fonts/Montserrat-Regular.ttf" }
    FontLoader { source: "qrc:/qt/qml/Sable_CRM/Resources/fonts/Montserrat-Bold.ttf"    }

    background: Rectangle
    {
        anchors.fill: parent
        radius: 10
        color: Theme.palette.background
        opacity: 0.2
    }

    Rectangle
    {
        anchors.fill: parent
        radius: 10
        color: Theme.palette.background
    }

    Connections
    {
        target: AuthManager

        function onTokenAuth_expired()
        {
            authError.text = "Предыдущая сессия завершена, авторизируйтесь заново"
        }

        function onInvalidLogin()
        {
            login.colors.border = "red"
            password.colors.border = "red"
            authError.text = "Не верный логин или пароль"
        }

        function onValidLogin()
        {
            login.colors.border = le_borderColor
        }

        function onInvalidPassword()
        {
            login.colors.border = "red"
            password.colors.border = "red"
            authError.text = "Не верный логин или пароль"
        }

        function onValidPassword()
        {
            password.colors.border = le_borderColor
        }

        function onUserNotFound()
        {
            authError.text = "Пользователь не найден"
        }

        function onIncorrectData()
        {
            login.colors.border = "red"
            password.colors.border = "red"
            authError.text = "Не верный логин или пароль"
        }

        function onSuccess()
        {
            authError.text = ""
            login.enabled = false
            password.enabled = false
            logIn.enabled = false
        }

        function onLogout()
        {
            login.enabled = true
            password.enabled = true
            logIn.enabled = true
        }
    }

    ColumnLayout
    {
        anchors.fill: parent
        Component.onCompleted: AuthManager.restoreSession()

        // Header
        Rectangle
        {
            height: 190
            radius: 10
            Layout.fillWidth: true

            gradient: Gradient
            {
                GradientStop { position: 0.0; color: Theme.palette.gradient.start }
                GradientStop { position: 1.0; color: Theme.palette.gradient.end   }
            }

            Image
            {
                id: logo
                source: Theme.palette.icon.logo
                width:  64
                height: 80

                anchors.right:          parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin:    50
            }

            Text
            {
                id: name
                text: "Sable"

                anchors.left: logo.right
                anchors.top:  logo.top
                anchors.leftMargin: 10

                font.pixelSize: 48
                font.weight:    Font.Bold

                color: Theme.palette.text.alter
            }

            Text
            {
                text: "CRM SYSTEM"

                font.weight: Font.Bold
                font.pixelSize: 18
                color: "white"

                anchors.left:  logo.right
                anchors.right: parent.right
                anchors.top:   name.bottom
                anchors.leftMargin: name.anchors.leftMargin
            }
        }

        Item { Layout.fillHeight: true }

        LineEdit
        {
            id: login

            Layout.fillWidth: true
            Layout.leftMargin: 50
            Layout.rightMargin: 50
            Layout.minimumHeight: 70

            radius: 10

            placeholderText: "Login"

            colors.background: enabled ? le_bgColor : le_bgColor_disabled
            colors.border: le_borderColor
            colors.border_hovered: le_borderColor_hovered

            font.pixelSize: 20

            imgSource: Theme.palette.icon.user_circle
            imgWidth:  30
            imgHeight: imgWidth
        }

        LineEdit
        {
            id: password

            property url eye_open:   Theme.palette.icon.eye_circle
            property url eye_closed: Theme.palette.icon.eye_slash_circle

            radius: 10
            Layout.fillWidth: true
            Layout.leftMargin: 50
            Layout.rightMargin: 50
            Layout.minimumHeight: 70

            placeholderText: "Password"

            colors.background: enabled ? le_bgColor : le_bgColor_disabled
            colors.border: le_borderColor
            colors.border_hovered: le_borderColor_hovered

            font.pixelSize:   20

            imgSource: Theme.palette.icon.lock_circle
            imgWidth:  30
            imgHeight: imgWidth

            echoMode: inputMode.checked ? TextInput.Normal : TextInput.Password

            Button
            {
                id: inputMode

                width:  password.imgWidth
                height: password.imgWidth

                focusPolicy: Qt.NoFocus;
                checkable: true

                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 20

                background: Image
                {
                    anchors.fill: parent
                    source: parent.checked ? password.eye_open : password.eye_closed
                }
            }
        }

        PushButton
        {
            id: logIn

            radius: 10
            Layout.fillWidth: true
            Layout.minimumHeight: 70
            Layout.leftMargin: 50
            Layout.rightMargin: 50

            colors.text_hovered:   enabled ? Theme.palette.text.alter : "white"
            colors.border_hovered: enabled ? Theme.palette.text.alter : "transparent"
            text: "Log In"
            font.bold: true
            colors.text: "white"
            font.pixelSize: 20
            colors.animationDur: 120

            colors.background_gradient: Gradient
            {
                GradientStop { position: 0.0; color: logIn.hovered ? Theme.palette.gradient.start_hover : Theme.palette.gradient.start }
                GradientStop { position: 1.0; color: logIn.hovered ? Theme.palette.gradient.end_hover   : Theme.palette.gradient.end   }
            }

            function authorize()
            {
                AuthManager.authorize(login.inputText, password.inputText)
            }

            onPressed: authorize()

            Message
            {
                id: authError
                visible: text !== ""
                spacing: 10

                color: "red"
                picSource: Theme.palette.icon.attention
                picSize: 20
                font.pixelSize: 14
                font.weight: Font.Bold

                anchors.topMargin: 5
                anchors.top: parent.bottom
            }
        }

        Item { Layout.fillHeight: true }

        Keys.onPressed: function(event)
        {
            switch(event.key)
            {
            case Qt.Key_Enter:
            case Qt.Key_Return:
                logIn.authorize()
                break
            }
        }
    }
}
