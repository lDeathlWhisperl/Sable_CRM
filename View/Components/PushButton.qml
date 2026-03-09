import QtQuick
import QtQuick.Controls.Basic

Item
{
    id: root

    property alias text:     txt.text
    property alias fontSize: txt.font.pixelSize
    property alias radius:   btn_rect.radius

    property color textColor:           "black"
    property color textColor_hovered:   textColor
    property color bgColor:             "white"
    property color bgColor_hovered:     bgColor
    property color borderColor:         "transparent"
    property color borderColor_hovered: borderColor
    property Gradient bgGradient:       null
    property string fontFamily:         ""
    property int fontWeight:            Font.Normal

    signal pressed()

    Button
    {
        id: btn

        anchors.fill: parent

        background: Rectangle
        {
            id: btn_rect

            anchors.fill: parent
            color:        bgGradient ? "" : (btn.hovered ? bgColor_hovered : bgColor)
            border.color: btn.hovered ? borderColor_hovered : borderColor
            gradient:     bgGradient

            Behavior on color
            {
                ColorAnimation { duration: 120 }
            }

            Behavior on border.color
            {
                ColorAnimation { duration: 120 }
            }
        }

        Text
        {
            id: txt

            color:          btn.hovered ? textColor_hovered : textColor
            anchors.fill:   parent
            font.pixelSize: 14
            font.family:    fontFamily
            font.weight:    fontWeight

            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment:   Qt.AlignVCenter

            Behavior on color
            {
                ColorAnimation { duration: 120 }
            }
        }

        onPressed: root.pressed()
    }
}
