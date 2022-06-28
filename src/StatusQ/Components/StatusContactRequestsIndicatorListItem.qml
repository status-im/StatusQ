import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Components 0.1

StatusListItem {
    id: statusContactRequestsListItem

    implicitHeight: Theme.dp(64)
    implicitWidth: Theme.dp(288)

    color: sensor.containsMouse ? Theme.palette.baseColor2 : "transparent"

    property int requestsCount: 0

    components: [
        StatusBadge {
            visible:  statusContactRequestsListItem.requestsCount > 0
            value: statusContactRequestsListItem.requestsCount
            anchors.verticalCenter: parent.verticalCenter
            border.width: Theme.dp(4)
            border.color: color
        },
        StatusIcon {
            icon: "chevron-down"
            rotation: 270
            color: Theme.palette.baseColor1
        }
    ]
}


