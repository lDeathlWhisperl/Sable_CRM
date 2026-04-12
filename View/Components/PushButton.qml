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
    property int colorAnimDur:          0

    signal pressed()
    signal released()
    signal clicked()

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
                ColorAnimation { duration: colorAnimDur }
            }

            Behavior on border.color
            {
                ColorAnimation { duration: colorAnimDur }
            }
        }

        Text
        {
            id: txt

            color:          btn.hovered ? textColor_hovered : textColor
            anchors.fill:   parent
            font.pixelSize: fontSize
            font.family:    fontFamily
            font.weight:    fontWeight

            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment:   Qt.AlignVCenter

            wrapMode: Text.WordWrap

            Behavior on color
            {
                ColorAnimation { duration: colorAnimDur }
            }
        }

        onPressed: root.pressed()
        onReleased: root.released()
        onClicked: root.clicked()
    }
}
