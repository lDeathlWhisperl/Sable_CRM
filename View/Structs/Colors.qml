import QtQuick 2.15

QtObject
{
    property color text:                            "black"
    property color text_hovered:                    text
    property color background:                      "white"
    property color background_hovered:              background
    property color border:                          "transparent"
    property color border_hovered:                  border
    property Gradient background_gradient:          null
    property Gradient background_gradient_hovered:  null
    property int animationDur:                      0
}
