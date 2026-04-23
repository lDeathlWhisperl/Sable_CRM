import QtQuick
import QtQuick.Controls.Basic

import "../Structs"

ComboBox
{
    id: root
    property alias radius: bg.radius
    property Colors colors: Colors {}

    background: Rectangle
    {
        id: bg

        color: root.hovered ? colors.background_hovered : colors.background
        border.color: root.hovered ? colors.border_hovered : colors.border
        gradient: root.hovered ? colors.background_gradient_hovered : colors.background_gradient

        bottomLeftRadius: root.down ? 0 : radius
        bottomRightRadius: root.down ? 0 : radius
    }

    contentItem: Text
    {
        text: root.displayText
        color: colors.text
        verticalAlignment: Text.AlignVCenter
        leftPadding: 10
    }

    delegate: ItemDelegate
    {
        contentItem: Text
        {
            text: modelData
            color: hovered ? colors.text_hovered : colors.text
        }
    }

    popup: Popup
    {
        y: root.height - bg.border.width
        width: root.width

        contentItem: ListView
        {
            implicitHeight: contentHeight
            spacing: 5
            model: root.delegateModel
        }

        background: Rectangle
        {
            color: colors.background
            border.color: colors.border

            radius: root.radius
            topLeftRadius: root.down ? 0 : radius
            topRightRadius: root.down ? 0 : radius
        }
    }
}
