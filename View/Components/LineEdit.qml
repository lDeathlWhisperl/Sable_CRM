import QtQuick
import QtQuick.Controls.Basic

import "../Structs"
import Theme

TextField
{
    id: field
    color: Theme.palette.text.primary

    property alias radius: f_rect.radius
    property int borderWidth: 1

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

    readonly property string inputText: field.text

    echoMode: TextInput.Normal

    placeholderTextColor: Theme.palette.text.placeholder

    leftPadding: imgSource == "" ? 20 : 20 + imgWidth + 20

    font.pixelSize: 14

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
