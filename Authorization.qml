import QtQuick
import QtQuick.Controls.Basic

import loginvalidator

Window
{
    id: root
    width: 610
    height: 725

    maximumWidth:  width
    minimumWidth:  width
    maximumHeight: height
    minimumHeight: height

    visible: true
    title:   "Sable"

    FontLoader { source: "resources/fonts/Montserrat-Regular.ttf" }
    FontLoader { source: "resources/fonts/Montserrat-Bold.ttf" }

    Item
    {
        anchors.fill: parent
        Rectangle
        {
            id: header

            height: 190
            bottomLeftRadius: 10
            bottomRightRadius: 10

            anchors.top:   parent.top
            anchors.left:  parent.left
            anchors.right: parent.right

            gradient: Gradient
            {
                GradientStop { position: 0.0; color: "#94ccf3" }
                GradientStop { position: 1.0; color: "#65afed" }
            }

            Image
            {
                id: logo
                source: "resources/images/Logo.png"
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

                bgColor:     "#f9f9fb"
                borderColor: "#f0f0f3"
                borderColor_hovered: "#68b4f0"

                fontFamily: "Montserrat"
                fontSize:   20

                imgSource: "resources/images/user_circle.svg"
                imgWidth:  30
                imgHeight: imgWidth
            }

            LineEdit
            {
                id: password

                property url eye_open:   "resources/images/eye_circle.svg"
                property url eye_closed: "resources/images/eye_slash_circle.svg"

                width:  470
                height: 70
                radius: 10

                placeholder: "Password"

                bgColor:     "#f9f9fb"
                borderColor: "#f0f0f3"
                borderColor_hovered: "#68b4f0"

                fontFamily: "Montserrat"
                fontSize:   20

                imgSource: "resources/images/lock_circle.svg"
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

                textColor_hovered:   "#324564"
                borderColor_hovered: "#324564"
                text:       "Log In"
                fontFamily: "Montserrat"
                fontWeight: Font.Bold
                textColor:  "white"
                fontSize:   20

                bgGradient: Gradient
                {
                    GradientStop { position: 0.0; color: "#68b4f0" }
                    GradientStop { position: 1.0; color: "#3797e9" }
                }

                LoginValidator { id: validator }
                onPressed:
                {
                    validator.validate(login.inputText, password.inputText)
                    authError.msgText = ""

                    if(!validator.isLoginValid || !validator.isPasswordValid)
                        authError.msgText = "Некорректрый логин или пароль"

                    if(!validator.isLoginValid)
                    {
                        login.borderColor = "red"
                        login.borderWidth = 2
                    }
                    else
                    {
                        login.borderColor = "#f0f0f3"
                        login.borderWidth = 1
                    }

                    if(!validator.isPasswordValid)
                    {
                        password.borderColor = "red"
                        password.borderWidth = 2
                    }
                    else
                    {
                        password.borderColor = "#f0f0f3"
                        password.borderWidth = 1
                    }
                }

                ErrorMessage
                {
                    id: authError
                    visible: msgText !== ""
                    spacing: 10

                    picSize: 20
                    msgFontSize: 14
                    msgFontFamily: "Montserrat"
                    msgFontWeight: Font.Bold

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
