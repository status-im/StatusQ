import QtQuick 2.14
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.14

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Controls 0.1

/*!
  /note beware, the slider processes the mouse events only in its control space. So it must be at least as high
  as the /c handle so user can grab it fully.
 */
Slider {
    id: root

    property int handleSize: Theme.dp(28)
    property int bgHeight: Theme.dp(4)
    property color handleColor: Theme.palette.white
    property color bgColor: Theme.palette.baseColor2
    property color fillColor: Theme.palette.primaryColor1

    property alias decoration: decorationContainer.sourceComponent

    implicitWidth: Theme.dp(360)
    implicitHeight: Math.max(handle.implicitHeight,
                             background.implicitHeight + decorationContainer.height)

    leftPadding: 0

    background: Rectangle {
        id: bgRect

        x: root.leftPadding
        y: root.topPadding
        implicitWidth: Theme.dp(100)
        implicitHeight: bgHeight
        width: root.availableWidth
        height: implicitHeight
        color: root.bgColor
        radius: Theme.dp(2)

        Loader {
            id: decorationContainer
            anchors.top: parent.top
            width: parent.height
        }

        Rectangle {
            width: root.visualPosition * parent.width
            height: parent.height
            color: root.fillColor
            radius: Theme.dp(2)
        }
    } // background

    handle: Rectangle {
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width / 2)
        anchors.verticalCenter: bgRect.verticalCenter
        color: root.handleColor
        implicitWidth: root.handleSize
        implicitHeight: root.handleSize
        radius: root.handleSize / 2
        layer.enabled: true
        layer.effect: DropShadow {
            width: parent.width
            height: parent.height
            visible: true
            verticalOffset: Theme.dp(2)
            samples: 15
            fast: true
            cached: true
            color: Theme.palette.dropShadow
        }
    }
}
