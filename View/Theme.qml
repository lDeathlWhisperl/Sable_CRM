pragma Singleton
import QtQuick

QtObject
{
    property string current: "light"

    readonly property var themes: ({
        light:
        {
            background: "#f4f5fa",
            surface:    "#fefefe",
            border:
            {
                primary: "#e1e2e9",
                hover:   "#cfd2dc"
            },
            text:
            {
                primary: "#3a4150",
                hover:   "#3a3150",
                placeholder: "#9aa3b2"
            },
            gradient:
            {
                start: "#68b4f0",
                end:   "#3797e9",
                start_hover: "#7cc0f5",
                end_hover:   "#4aa3ed"
            },
            button:
            {
                primary: "#1465d4",
                hover:   "#22618c"
            }
        },
       dark:
        {
            background: "#0F172A",
            surface:    "#1E293B",

            border:
            {
                primary: "#2A3445",
                hover:   "#3A475C"
            },

            text:
            {
                primary: "#E5E7EB",
                hover:   "#FFFFFF",
                placeholder: "#64748B"
            },

            gradient:
            {
                start: "#3B82F6",
                end:   "#2563EB",

                start_hover: "#60A5FA",
                end_hover:   "#3B82F6"
            },

            button:
            {
                primary: "#2563EB",
                hover:   "#3B82F6"
            }
        }
    })

    property var palette: themes[current]
}
