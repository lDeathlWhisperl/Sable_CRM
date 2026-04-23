import QtQuick
import Theme

Text
{
    property string name
    property color tag_color

    id: root
    text: name
    color: tag_color.a === 0 ? Theme.palette.text.primary : rc.text
    font.bold: true
    padding: 10
    font.pixelSize: 18

    Rectangle
    {
        anchors.fill: parent
        color: tag_color.a === 0 ? "transparent" : parent.rc.bg
        border.color: parent.rc.border
        border.width: 1
        radius: 25
    }

    property var rc: roleColor(Qt.color(tag_color), Theme.current)
    function roleColor(base, theme)
    {
        if (theme === "light")
        {
            return {
                bg: Qt.rgba(base.r, base.g, base.b, 0.12),
                text: Qt.darker(base, 1.4),
                border: Qt.darker(base, 1.2),
                hover: Qt.rgba(base.r, base.g, base.b, 0.3)
            }
        }
        else
        {
            return {
                bg: Qt.rgba(base.r, base.g, base.b, 0.2),
                text: Qt.lighter(base, 1.3),
                border: Qt.lighter(base, 1.1),
                hover: Qt.rgba(base.r, base.g, base.b, 0.4)
            }
        }
    }
}
