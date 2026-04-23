import QtQuick
import QtQuick.Layouts
import Theme

import "../Structs"

Rectangle
{
    id: root
    radius: 10

    property Colors colors: Colors {}
    property User user: User
    {
        photo: Theme.palette.icon.user // default
    }

    color: colors.background
    border.color: colors.border
    border.width: 1

    ColumnLayout
    {
        spacing: 10
        anchors.fill: parent
        anchors.margins: 10

        RowLayout
        {
            spacing: 10

            Image
            {
                id: prof_pic
                Layout.preferredHeight: 40
                Layout.preferredWidth: 40
                source: user.photo
            }

            Column
            {
                Layout.fillWidth: true
                Text
                {
                    text: user.name
                    color: Theme.palette.text.primary
                }
                Text
                {
                    text: user.phone
                    color: Theme.palette.text.primary
                }
            }

            RoleTag
            {
                name: user.role_name
                tag_color: user.role_color
            }
        }

        Rectangle
        {
            Layout.fillWidth: true
            Layout.minimumHeight: 1
            Layout.maximumHeight: 1
            color: root.colors.border
        }


        Item { Layout.fillHeight: true } // Spacer
    }
}
