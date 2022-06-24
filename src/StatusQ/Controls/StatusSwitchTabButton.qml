import QtQuick 2.14
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.13

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

TabButton {
    id: statusSwitchTabButton

    contentItem: Item {
        height: Theme.dp(36)
        MouseArea {
            id: sensor
            hoverEnabled: true
            anchors.fill: parent

            cursorShape: Qt.PointingHandCursor
            onPressed: mouse.accepted = false
            onReleased: mouse.accepted = false

            StatusBaseText {
                id: label
                text: statusSwitchTabButton.text
                color: statusSwitchTabButton.checked ?
                    Theme.palette.statusSwitchTab.selectedTextColor :
                    Theme.palette.statusSwitchTab.textColor
                font.weight: Font.Medium
                font.pixelSize: Theme.dp(15)
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
            }
        }
    }

    background: Rectangle {
        id: controlBackground
        implicitHeight: Theme.dp(36)
        implicitWidth: Theme.dp(148)
        color: statusSwitchTabButton.checked ?
            Theme.palette.statusSwitchTab.buttonBackgroundColor :
            "transparent"
        radius: Theme.dp(8)
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 0
            radius: Theme.dp(10)
            samples: 25
            spread: 0
            color: Theme.palette.dropShadow
        }
    }
}
