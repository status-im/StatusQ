import QtQuick 2.12

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Controls 0.1
import StatusQ.Components 0.1
import StatusQ.Popups 0.1

StatusModal {
    id: root

    anchors.centerIn: parent

    header.title: "Cryptokitties"
    header.subTitle: "Public Community"
    header.image.source: "https://pbs.twimg.com/profile_images/1369221718338895873/T_5fny6o_400x400.jpg"

    contentItem: Column {
        width: root.width

        StatusModalDivider {
            bottomPadding: Theme.dp(8)
        }

        StatusBaseText {
            text: "A community of cat lovers, meow!"
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: Theme.dp(15)
            height: Theme.dp(46)
            color: Theme.palette.directColor1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: Theme.dp(16)
            anchors.rightMargin: Theme.dp(16)
        }

        StatusModalDivider {
            topPadding: Theme.dp(8)
            bottomPadding: Theme.dp(8)
        }

        StatusDescriptionListItem {
            title: "Share community"
            subTitle: "https://join.status.im/u/0x04...45f19"
            tooltip.text: "Copy to clipboard"
            icon.name: "copy"
            iconButton.onClicked: tooltip.visible = !tooltip.visible
            width: parent.width
        }

        StatusModalDivider {
            topPadding: Theme.dp(8)
            bottomPadding: Theme.dp(8)
        }

        StatusListItem {
            anchors.horizontalCenter: parent.horizontalCenter
            statusListItemTitle.font.pixelSize: Theme.dp(17)
            title: "Members"
            icon.name: "group-chat"
            label: "184"
            components: [
                StatusIcon {
                    icon: "chevron-down"
                    rotation: 270
                    color: Theme.palette.baseColor1
                }
            ]
        }

        StatusListItem {
            anchors.horizontalCenter: parent.horizontalCenter
            statusListItemTitle.font.pixelSize: 17
            title: "Notifications"
            icon.name: "notification"
            components: [
                StatusSwitch {}
            ]
        }

        StatusModalDivider {
            topPadding: Theme.dp(8)
            bottomPadding: Theme.dp(8)
        }

        StatusListItem {
            anchors.horizontalCenter: parent.horizontalCenter
            statusListItemTitle.font.pixelSize: Theme.dp(17)
            title: "Edit community"
            icon.name: "edit"
            type: StatusListItem.Type.Secondary
        }

        StatusListItem {
            anchors.horizontalCenter: parent.horizontalCenter
            statusListItemTitle.font.pixelSize: Theme.dp(17)
            title: "Transfer ownership"
            icon.name: "exchange"
            type: StatusListItem.Type.Secondary
        }

        StatusListItem {
            anchors.horizontalCenter: parent.horizontalCenter
            statusListItemTitle.font.pixelSize: Theme.dp(17)
            title: "Leave community"
            icon.name: "arrow-right"
            icon.rotation: 180
            type: StatusListItem.Type.Secondary
        }
    }
}
