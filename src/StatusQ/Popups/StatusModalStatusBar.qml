import QtQuick 2.14

import StatusQ.Core 0.1

Column {
    id: statusBar
    width: parent.width

    property color backgroundColor
    property color bordersColor
    property color fontColor
    property string statusText
    property int textPixels: 15
    property int statusBarHeight: 38

    Rectangle {
        id: topDiv
        color: statusBar.bordersColor
        height: 1
        width: parent.width
    }

    // Status bar content:
    Rectangle {
        id: statusBox
        width: parent.width
        height: statusBar.statusBarHeight
        color: statusBar.backgroundColor

        StatusBaseText {
            id: statusTxt
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: statusBar.textPixels
            text: statusBar.statusText
            color: statusBar.fontColor
        }
    }

    Rectangle {
        id: bottomDiv
        color: statusBar.bordersColor
        height: 1
        width: parent.width
    }
}
