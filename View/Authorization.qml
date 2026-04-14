import QtQuick
import QtQuick.Controls.Basic

import "Components"

import App.auth

Popup
{
    id: root
    width: 610
    height: 725

    readonly property string res: "qrc:/qt/qml/Sable_CRM/Resources/"
    property color le_bgColor: "#f9f9fb"
    property color le_bgColor_disabled: "#325664"
    property color le_borderColor: "#e1e2e9"
    property color le_borderColor_hovered: "#68b4f0"
    property Gradient gradient: Gradient
    {
        GradientStop { position: 0.0; color: "#68b4f0" }
        GradientStop { position: 1.0; color: "#3797e9" }
    }

    modal: true
    closePolicy: Popup.NoAutoClose

    FontLoader { source: res + "fonts/Montserrat-Regular.ttf" }
    FontLoader { source: res + "fonts/Montserrat-Bold.ttf" }

    background: Rectangle
    {
        anchors.fill: parent
        radius: 10
        color: "#f4f5fa"
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
            authError.text = "Не верный логин или пароль"
        }

        function onValidLogin()
        {
            login.colors.border = le_borderColor
        }

        function onInvalidPassword()
        {
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

    Item
    {
        anchors.fill: parent
        Rectangle
        {
            id: header

            height: 190
            radius: 10
            // bottomLeftRadius: 10
            // bottomRightRadius: 10

            anchors.top:   parent.top
            anchors.left:  parent.left
            anchors.right: parent.right

            gradient: root.gradient

            Image
            {
                id: logo
                source: res + "images/Logo.png"
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
                font.family:    "Montserrat"
                font.weight:    Font.Bold

                color: "#324564"
            }

            Text
            {
                text: "CRM SYSTEM"

                font.family: "Montserrat"
                font.weight: Font.Bold
                font.pixelSize: 18
                color: "white"

                anchors.left:  logo.right
                anchors.right: parent.right
                anchors.top:   name.bottom
                anchors.leftMargin: name.anchors.leftMargin
            }
        }

        Column
        {
            spacing: 10
            Component.onCompleted: AuthManager.restoreSession()

            anchors
            {
                top: header.bottom
                topMargin: 100
                horizontalCenter: parent.horizontalCenter
            }

            LineEdit
            {
                id: login

                width:  470
                height: 70
                radius: 10

                placeholder: "Login"

                colors.background:     enabled ? le_bgColor : le_bgColor_disabled
                colors.border: le_borderColor
                colors.border_hovered: le_borderColor_hovered

                font.family: "Montserrat"
                font.pixelSize:   20

                imgSource: res + "images/user_circle.svg"
                imgWidth:  30
                imgHeight: imgWidth
            }

            LineEdit
            {
                id: password

                property url eye_open:   res + "images/eye_circle.svg"
                property url eye_closed: res + "images/eye_slash_circle.svg"

                width:  470
                height: 70
                radius: 10

                placeholder: "Password"

                colors.background:     enabled ? le_bgColor : le_bgColor_disabled
                colors.border: le_borderColor
                colors.border_hovered: le_borderColor_hovered

                font.family: "Montserrat"
                font.pixelSize:   20

                imgSource: res + "images/lock_circle.svg"
                imgWidth:  30
                imgHeight: imgWidth

                mode: inputMode.checked ? TextInput.Normal : TextInput.Password

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

                width:  470
                height: 70
                radius: 10

                colors.text_hovered:   enabled ? "#324564" : "white"
                colors.border_hovered: enabled ? "#324564" : "transparent"
                text:       "Log In"
                font.bold:  true
                colors.text:  "white"
                font.pixelSize: 20
                colors.animationDur: 120

                colors.background_gradient: gradient

                onPressed:
                {
                    AuthManager.authorize(login.inputText, password.inputText)
                }

                ErrorMessage
                {
                    id: authError
                    visible: text !== ""
                    spacing: 10

                    picSize: 20
                    font.pixelSize: 14
                    font.family: "Montserrat"
                    font.weight: Font.Bold

                    anchors.topMargin: 5
                    anchors.top: parent.bottom
                }
            }
        }

        Keys.onPressed: function(event)
        {
            switch(event.key)
            {
            case Qt.Key_Enter:
            case Qt.Key_Return:
                logIn.pressed();
                break;
            }
        }
    }
}
