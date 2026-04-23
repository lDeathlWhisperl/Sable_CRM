import QtQuick
import QtQuick.Controls
import QtQuick.Window 2.15

import App.auth

ApplicationWindow
{
    id: root
    visible: true
    title: "Sable"
    visibility: Window.Maximized

    minimumHeight: au.height
    minimumWidth: au.width

    Connections
    {
        target: AuthManager

        function onLogout()
        {
            stack.pop()
            au.open()
        }

        function onSuccess()
        {
            stack.push(workArea)
            au.close()
        }
    }

    Authorization
    {
        id: au

        anchors.centerIn: parent
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

        onOpened: modalOverlay.opacity = 0.6
        onClosed: modalOverlay.opacity = 0

        Component.onCompleted: open()
    }

    StackView
    {
        id: stack
        anchors.fill: parent

        initialItem: bg
    }

    Component
    {
        id: bg

        Rectangle
        {
            gradient: Gradient
            {
                GradientStop { position: 0.0; color: "#1e1e2f" }
                GradientStop { position: 1.0; color: "#12121a" }
            }

            Canvas
            {
                anchors.fill: parent
                opacity: 0.15

                onPaint:
                {
                    const ctx = getContext("2d")
                    ctx.reset()

                    const step = 40

                    ctx.strokeStyle = "#ffffff"
                    ctx.lineWidth = 1

                    for (let x = -height; x < width; x += step)
                    {
                        ctx.beginPath()
                        ctx.moveTo(x, 0)
                        ctx.lineTo(x + height, height)
                        ctx.stroke()
                    }
                }
            }
        }
    }

    Component
    {
        id: workArea
        WorkingArea {}
    }

    Rectangle
    {
        id: modalOverlay
        anchors.fill: parent
        color: "#324564"
        opacity: 0
        Behavior on opacity
        {
            NumberAnimation
            {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
    }
}
