import QtQuick
import QtQuick.Controls.Basic

Item
{
    id: root

    property alias placeholder: field.placeholderText
    property alias fontSize:    field.font.pixelSize
    property alias radius:      f_rect.radius

    property color borderColor:         "black"
    property color borderColor_hovered: borderColor
    property color bgColor:             "white"
    property color bgColor_hovered:     bgColor
    property int   borderWidth:         1

    property string fontFamily: ""
    property int    fontWeight: Font.Normal

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
        font.family:    fontFamily
        font.weight:    fontWeight

        background: Rectangle
        {
            id:           f_rect
            anchors.fill: parent
            border.color: field.hovered ? borderColor_hovered : borderColor
            border.width: borderWidth
            color:        field.hovered ? bgColor_hovered : bgColor

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
