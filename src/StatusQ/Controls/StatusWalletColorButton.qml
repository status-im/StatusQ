import QtQuick 2.13
import QtQuick.Controls 2.13

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Controls 0.1

StatusFlatRoundButton {
    id: control
    property bool selected: false
    icon.name: "filled-account"
    icon.width: Theme.dp(36)
    icon.height: Theme.dp(36)
    Rectangle {
        anchors.fill: parent
        color: control.hovered ? control.icon.color : "transparent"
        opacity: 0.1
        radius: Theme.dp(8)
    }

    Rectangle {
        width: Theme.dp(16)
        height: Theme.dp(16)
        anchors.top: parent.top
        anchors.topMargin: Theme.dp(2)
        anchors.right: parent.right
        anchors.rightMargin: Theme.dp(2)
        visible: control.selected
        radius: width / 2
        color: Theme.palette.successColor1
        StatusIcon {
            icon: "tiny/checkmark"
            height: Theme.dp(12)
            color: Theme.palette.white
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}


