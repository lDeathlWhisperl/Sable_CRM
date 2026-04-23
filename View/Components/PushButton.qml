import QtQuick
import QtQuick.Controls.Basic

import "../Structs"

Button
{
    id: btn
    property alias radius: btn_rect.radius
    readonly property Colors colors: Colors {}

    background: Rectangle
    {
        id: btn_rect

        anchors.fill: parent
        color:        colors.background_gradient ? "" : (btn.hovered ? colors.background_hovered : colors.background)
        border.color: btn.hovered ? colors.border_hovered : colors.border
        gradient:     colors.background_gradient

        Behavior on color
        {
            ColorAnimation { duration: colors.animationDur }
        }

        Behavior on border.color
        {
            ColorAnimation { duration: colors.animationDur }
        }
    }

    contentItem: Text
    {
        id: txt

        text: btn.text
        font: btn.font
        color:          btn.hovered ? colors.text_hovered : colors.text
        anchors.fill:   parent

        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment:   Qt.AlignVCenter

        wrapMode: Text.WordWrap

        Behavior on color
        {
            ColorAnimation { duration: colors.animationDur }
        }
    }
}
