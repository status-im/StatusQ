import StatusQ.Core.Theme 0.1
import StatusQ.Controls 0.1
import StatusQ.Core 0.1

StatusFlatRoundButton {
    id: statusChatListCategoryItemButton

    height: Theme.dp(22)
    width: Theme.dp(22)
    radius: Theme.dp(4)

    property bool highlighted: false
    property StatusTooltipSettings tooltip: StatusTooltipSettings {}

    type: StatusFlatRoundButton.Type.Secondary
    icon.width: Theme.dp(20)
    icon.color: Theme.palette.directColor4

    color: hovered || highlighted ? 
        Theme.palette.statusChatListCategoryItem.buttonHoverBackgroundColor : 
        "transparent"

    StatusToolTip {
        id: statusToolTip
        visible: !!text && parent.hovered
        text: tooltip.text
        orientation: tooltip.orientation
        offset: tooltip.offset
    }
}

