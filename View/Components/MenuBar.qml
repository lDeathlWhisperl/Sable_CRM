import QtQuick

import "../Structs"
import Theme

Item
{
    id: root
    property color bgColor: Theme.palette.surface
    property var model

    readonly property Category category: Category
    {
        current: model[0]
        last: ""
    }

    property Gradient gradient: Gradient
    {
        GradientStop { position: 0.0; color: parent.hovered ? Theme.palette.gradient.start_hover : Theme.palette.gradient.start }
        GradientStop { position: 1.0; color: parent.hovered ? Theme.palette.gradient.end_hover   : Theme.palette.gradient.end   }
    }

    Rectangle
    {
        anchors.fill: col
        color: bgColor
    }

    Column
    {
        id: col
        anchors.fill: parent
        spacing: 10
        padding: 10

        Repeater
        {
            id: repeater
            model: root.model

            PushButton
            {
                id: btn
                text: modelData
                height: 50
                width: col.width - col.padding * 2
                radius: 10

                colors.background: root.bgColor
                colors.border_hovered: Theme.palette.gradient.start
                colors.background_gradient: modelData === category.current ? gradient : null
                colors.text: Theme.palette.text.primary

                font.bold: true
                font.pixelSize: 12

                onPressed:
                {
                    category.last = category.current
                    category.current = modelData
                }
            }
        }
    }
}
