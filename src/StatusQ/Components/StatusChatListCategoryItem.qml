import QtQuick 2.13

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Controls 0.1
import StatusQ.Components 0.1

StatusListItem {
    id: statusChatListCategoryItem

    implicitWidth: 288
    implicitHeight: 28

    leftPadding: 8
    rightPadding: 8

    property bool opened: true
    property bool highlighted: false
    property bool showActionButtons: false
    property alias addButton: addButton
    property alias menuButton: menuButton
    property alias toggleButton: toggleButton

    signal clicked(var mouse)
    signal addButtonClicked(var mouse)
    signal menuButtonClicked(var mouse)
    signal toggleButtonClicked(var mouse)

    color: sensor.containsMouse || highlighted ? Theme.palette.baseColor2 : "transparent"

    sensor.onClicked: statusChatListCategoryItem.clicked(mouse)

    statusListItemTitle.color: Theme.palette.directColor4
    statusListItemTitle.font.weight: Font.Medium

    statusListItemComponentsSlot.spacing: 1

    components: [
        StatusChatListCategoryItemButton {
            id: addButton
            icon.name: "add"
            icon.width: 20
            visible: statusChatListCategoryItem.showActionButtons && 
                (statusChatListCategoryItem.highlighted ||
                statusChatListCategoryItem.sensor.containsMouse)
            onClicked: statusChatListCategoryItem.addButtonClicked(mouse)
            tooltip.text: "Add channel inside category"
        },
        StatusChatListCategoryItemButton {
            id: menuButton
            icon.name: "more"
            icon.width: 21
            visible: statusChatListCategoryItem.showActionButtons && 
                (statusChatListCategoryItem.highlighted ||
                statusChatListCategoryItem.sensor.containsMouse)
            onClicked: statusChatListCategoryItem.menuButtonClicked(mouse)
            tooltip.text: "More"
        },
        StatusChatListCategoryItemButton {
            id: toggleButton
            icon.name: "chevron-down"
            icon.width: 18
            icon.rotation: statusChatListCategoryItem.opened ? 0 : 270
            onClicked: statusChatListCategoryItem.toggleButtonClicked(mouse)
        }
    ]
}

