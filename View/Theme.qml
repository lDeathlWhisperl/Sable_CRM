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
                placeholder: "#9aa3b2",
                alter: "#325664"
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
            },
            icon:
            {
                logo:             "qrc:/qt/qml/Sable_CRM/Resources/images/Logo.png",
                attention:        "qrc:/qt/qml/Sable_CRM/Resources/images/attention.svg",         // https://www.svgrepo.com/svg/479044/attention
                check:            "qrc:/qt/qml/Sable_CRM/Resources/images/light_check.svg",             // https://www.svgrepo.com/svg/532154/check
                eye_circle:       "qrc:/qt/qml/Sable_CRM/Resources/images/light_eye_circle.svg",        // https://www.svgrepo.com/svg/532493/eye
                eye_slash_circle: "qrc:/qt/qml/Sable_CRM/Resources/images/light_eye_slash_circle.svg",  // https://www.svgrepo.com/svg/532465/eye-slash
                info:             "qrc:/qt/qml/Sable_CRM/Resources/images/light_info.svg",              // https://www.svgrepo.com/svg/525388/info-circle
                lock:             "qrc:/qt/qml/Sable_CRM/Resources/images/light_lock.svg",              // https://www.svgrepo.com/svg/532320/lock
                lock_circle:      "qrc:/qt/qml/Sable_CRM/Resources/images/light_lock_circle.svg",       //
                user:             "qrc:/qt/qml/Sable_CRM/Resources/images/light_user.svg",              // https://www.svgrepo.com/svg/532362/user
                user_circle:      "qrc:/qt/qml/Sable_CRM/Resources/images/light_user_circle.svg"        //
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
                placeholder: "#64748B",
                alter: "#325664"
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
            },
            icon:
            {
                logo:             "qrc:/qt/qml/Sable_CRM/Resources/images/Logo.png",
                attention:        "qrc:/qt/qml/Sable_CRM/Resources/images/attention.svg",
                check:            "qrc:/qt/qml/Sable_CRM/Resources/images/dark_check.svg",
                eye_circle:       "qrc:/qt/qml/Sable_CRM/Resources/images/dark_eye_circle.svg",
                eye_slash_circle: "qrc:/qt/qml/Sable_CRM/Resources/images/dark_eye_slash_circle.svg",
                info:             "qrc:/qt/qml/Sable_CRM/Resources/images/dark_info.svg",
                lock:             "qrc:/qt/qml/Sable_CRM/Resources/images/dark_lock.svg",
                lock_circle:      "qrc:/qt/qml/Sable_CRM/Resources/images/dark_lock_circle.svg",
                user:             "qrc:/qt/qml/Sable_CRM/Resources/images/dark_user.svg",
                user_circle:      "qrc:/qt/qml/Sable_CRM/Resources/images/dark_user_circle.svg"
            }
        }
    })

    property var palette: themes[current]
}
