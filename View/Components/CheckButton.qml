import QtQuick
import QtQuick.Controls.Basic
import Theme

import "../Structs"

CheckBox
{
    id: root

    property Colors colors: Colors
    {
        border: Theme.palette.border.primary
        border_hovered: Theme.palette.border.hover
        background: Theme.palette.button.primary
        background_hovered: Theme.palette.button.hover
    }

    indicator: Rectangle
    {
        color: checked ?
            (hovered ? colors.background_hovered :  colors.background) :
            Theme.palette.surface

        Behavior on color { ColorAnimation { duration: 300; easing.type: Easing.InOutQuad } }

        border.color: hovered ? colors.border_hovered : colors.border
        width: 20
        height: 20
        radius: width / 2
        anchors.centerIn: parent
        Rectangle
        {
            visible: checked
            anchors.centerIn: parent
            width: parent.width / 3
            height: parent.height / 3
            color: Theme.palette.background
            radius: width / 2
        }
    }
}
