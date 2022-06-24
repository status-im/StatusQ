import QtQuick 2.14
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

Rectangle {
    id: statusRoundedIcon

    property StatusIconSettings icon: StatusIconSettings {
        width: Theme.dp(24)
        height: Theme.dp(24)
        rotation: 0
        color: Theme.palette.primaryColor1
        background: StatusIconBackgroundSettings {
            width: Theme.dp(40)
            height: Theme.dp(40)
            color: Theme.palette.primaryColor3
        }
    }

    color: icon.background.color
    implicitWidth: icon.background.width
    implicitHeight: icon.background.height
    radius: icon.background.width / 2


    StatusIcon {
        id: statusIcon
        anchors.centerIn: parent

        width: statusRoundedIcon.icon.width
        height: statusRoundedIcon.icon.height

        color: statusRoundedIcon.icon.color
        icon: statusRoundedIcon.icon.name
        rotation: statusRoundedIcon.icon.rotation
    }
}
