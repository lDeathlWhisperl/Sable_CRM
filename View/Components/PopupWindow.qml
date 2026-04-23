import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../Structs"

Dialog
{
    id: root

    property alias text: content.text

    readonly property PushButton btn_Accept: btn_accept
    readonly property PushButton btn_Cancel: btn_cancel
    property bool btn_Accept_fillWidth: false
    property bool btn_Cancel_fillWidth: false
    property bool btn_left_fillWidth: false
    property bool btn_right_fillWidth: false

    property alias radius: bg.radius
    property alias border: bg.border

    readonly property Colors colors: Colors {}

    background: Rectangle
    {
        id: bg
        anchors.fill: parent

        border.color: colors.border
        color: colors.background
        gradient: colors.background_gradient
    }

    header: Item
    {
        implicitHeight: layout1.implicitHeight + 20
        ColumnLayout
        {
            id: layout1
            anchors.fill: parent

            Text
            {
                id: title
                anchors.margins: 10

                text: root.title
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 25
                font.weight: Font.Bold
                color: colors.text
            }

            Rectangle
            {
                Layout.fillWidth: true
                color: colors.border
                height: 1
            }
        }
    }

    contentItem: Item
    {
        Text
        {
            id: content
            anchors.fill: parent
            color: colors.text
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
        }
    }

    footer: Item
    {
        implicitHeight: layout2.implicitHeight + 20
        ColumnLayout
        {
            id: layout2
            anchors.fill: parent

            Rectangle
            {
                color: colors.border
                Layout.fillWidth: true
                height: 1
            }

            RowLayout
            {
                id: row
                spacing: 10
                Layout.fillHeight: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10

                Item { Layout.fillWidth: btn_left_fillWidth }

                PushButton
                {
                    id: btn_accept

                    Layout.preferredHeight: 40
                    Layout.fillWidth: btn_Accept_fillWidth
                    onReleased: root.accepted()
                }

                PushButton
                {
                    id: btn_cancel

                    Layout.preferredHeight: 40
                    Layout.fillWidth: btn_Cancel_fillWidth
                    onClicked: root.rejected()
                }

                Item { Layout.fillWidth: btn_right_fillWidth }
            }
        }
    }

    opacity: 0
    scale: 1
    transformOrigin: Item.Center
    enter: Transition
    {
        ParallelAnimation
        {
            NumberAnimation
            {
                property: "opacity"
                from: 0
                to: 1
                duration: 400
                easing.type: Easing.OutCubic
            }
            NumberAnimation
            {
                property: "scale"
                from: 0.9
                to: 1.0
                duration: 400
                easing.type: Easing.OutCubic
            }
        }
    }

    exit: Transition
    {
        ParallelAnimation
        {
            NumberAnimation
            {
                property: "opacity"
                to: 0
                duration: 400
                easing.type: Easing.InCubic
            }
            NumberAnimation
            {
                property: "scale"
                to: 0.9
                duration: 400
                easing.type: Easing.InCubic
            }
        }
    }
}
