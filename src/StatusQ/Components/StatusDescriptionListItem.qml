import QtQuick 2.13
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Controls 0.1

Rectangle {
    id: statusDescriptionListItem

    property string title: ""
    property string subTitle: ""
    property alias subTitleComponent: statusDescriptionListItemSubTitle
    property string value: ""
    property StatusIconSettings icon: StatusIconSettings {
        width: Theme.dp(23)
        height: Theme.dp(23)
    }
    property alias tooltip: statusToolTip
    property alias iconButton: statusFlatRoundButton
    property alias sensor: sensor

    implicitWidth: Theme.dp(448)
    implicitHeight: Theme.dp(56)
    radius: Theme.dp(8)

    color: Theme.palette.statusListItem.backgroundColor

    MouseArea {
        id: sensor
        anchors.fill: parent
        hoverEnabled: true
        enabled: false
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

        StatusBaseText {
            id: statusDescriptionListItemTitle
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: Theme.dp(16)
            anchors.topMargin: Theme.dp(5)

            color: Theme.palette.baseColor1
            text: statusDescriptionListItem.title
            font.pixelSize: Theme.dp(13)
            font.weight: Font.Medium
        }

        StatusBaseText {
            id: statusDescriptionListItemSubTitle
            anchors.top: statusDescriptionListItemTitle.bottom
            anchors.left: parent.left
            anchors.leftMargin: Theme.dp(16)
            anchors.topMargin: Theme.dp(4)

            text: statusDescriptionListItem.subTitle
            color: Theme.palette.directColor1
            font.pixelSize: Theme.dp(15)
            font.weight: Font.Normal
        }

        StatusFlatRoundButton {
            id: statusFlatRoundButton
            visible: !!statusDescriptionListItem.icon.name
            anchors.verticalCenter: statusDescriptionListItemSubTitle.verticalCenter
            anchors.left: statusDescriptionListItemSubTitle.right
            anchors.leftMargin: Theme.dp(4)

            width: Theme.dp(32)
            height: Theme.dp(32)

            icon.name: statusDescriptionListItem.icon.name
            icon.width: statusDescriptionListItem.icon.width
            icon.height: statusDescriptionListItem.icon.height

            StatusToolTip {
                id: statusToolTip
            }
        }

        Row {
            anchors.right: parent.right
            anchors.rightMargin: Theme.dp(16)
            anchors.verticalCenter: parent.verticalCenter
            visible: !!statusDescriptionListItem.value
            spacing: Theme.dp(8)

            StatusBaseText {
                text: statusDescriptionListItem.value
                color: Theme.palette.baseColor1
                font.pixelSize: Theme.dp(15)
                anchors.verticalCenter: parent.verticalCenter
            }

            StatusIcon {
                icon: "chevron-down"
                rotation: 270
                color: Theme.palette.baseColor1
            }
        }
    }
}
