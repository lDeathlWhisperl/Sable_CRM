import QtQuick
import QtQuick.Controls.Basic

import "../Structs"

Item
{
    id: root

    property alias text:     txt.text
    property alias radius:   btn_rect.radius
    property alias font:     txt.font

    readonly property Colors colors: Colors {}

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

        Text
        {
            id: txt

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

        onPressed: root.pressed()
        onReleased: root.released()
        onClicked: root.clicked()
    }
}
