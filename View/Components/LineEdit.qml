import QtQuick
import QtQuick.Controls.Basic

import "../Structs"

Item
{
    id: root

    property alias placeholder: field.placeholderText
    property alias radius:      f_rect.radius
    property int   borderWidth:         1

    property alias font: field.font

    readonly property Colors colors: Colors
    {
        border: "black"
        border_hovered: border
        background: "white"
        background_hovered: background
    }

    property url imgSource: ""
    property int imgWidth
    property int imgHeight

    property int mode: TextInput.Normal

    readonly property string inputText: field.text

    TextField
    {
        id: field

        echoMode: mode

        leftPadding: imgSource == "" ? 20 : 20 + imgWidth + 20

        anchors.fill:   parent

        font.pixelSize: 14
        font.family:    font.family
        font.weight:    font.weight

        background: Rectangle
        {
            id:           f_rect
            anchors.fill: parent
            border.color: field.hovered ? colors.border_hovered : colors.border
            border.width: borderWidth
            color:        field.hovered ? colors.background_hovered : colors.background

            Behavior on color
            {
                ColorAnimation { duration: 120 }
            }

            Behavior on border.color
            {
                ColorAnimation { duration: 120 }
            }
        }

        Image
        {
            visible: imgSource !== ""
            source:  imgSource
            width:   imgWidth
            height:  imgHeight

            anchors
            {
                verticalCenter: field.verticalCenter
                left: field.left
                leftMargin: 20
            }
        }
    }
}
