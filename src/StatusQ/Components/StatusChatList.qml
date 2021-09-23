import QtQuick 2.13
import QtQml.Models 2.14
import QtQuick.Controls 2.13 as QC

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Core.Utils 0.1
import StatusQ.Components 0.1
import StatusQ.Controls 0.1

Column {
    id: statusChatList

    spacing: 0
    width: 288

    property string uuid: Utils.uuid()

    property string categoryId: ""
    property string selectedChatId: ""
    property alias chatListItems: statusChatListItems
    property bool draggableItems: false

    property alias statusChatListItems: statusChatListItems

    property Component popupMenu

    property var filterFn
    property var profileImageFn
    property var chatNameFn

    signal chatItemSelected(string id)
    signal chatItemUnmuted(string id)
    signal chatItemReordered(string categoryId, string id, int from, int to)

    onPopupMenuChanged: {
        if (!!popupMenu) {
            popupMenuSlot.sourceComponent = popupMenu
        }
    }

    Column {
        id: statusChatListItemsWrapper
        width: parent.width
        spacing: 4
        onImplicitHeightChanged: {
            // For some reason, the binding on emptyListDropAreaLoaoder.active alone doesn't work.
            // We have to explicitly reassign it here.
            emptyListDropAreaLoader.active = implicitHeight == 0            
        }

        Repeater {
            id: statusChatListItems
            delegate: Item {
                id: draggable
                width: statusChatListItem.width
                height: statusChatListItem.height

                property alias chatListItem: statusChatListItem

                visible: {
                    if (!!statusChatList.filterFn) {
                        return statusChatList.filterFn(model, statusChatList.categoryId)
                    }
                    return true
                }

                MouseArea {
                    id: dragSensor

                    anchors.fill: parent
                    cursorShape: active ? Qt.ClosedHandCursor : Qt.PointingHandCursor
                    hoverEnabled: true
                    pressAndHoldInterval: 150
                    enabled: statusChatList.draggableItems

                    property bool active: false
                    property real startY: 0
                    property real startX: 0

                    drag.target: draggedListItemLoader.item
                    drag.threshold: 0.1
                    drag.filterChildren: true

                    onPressed: {
                        startY = mouseY
                        startX = mouseX
                    }

                    onPressAndHold: active = true
                    onReleased: {
                        if (active && (statusChatListItem.originalOder !== statusChatListItem.newOrder || 
                             statusChatListItem.categoryId !== statusChatListItem.newCategoryId)) {
                            statusChatList.chatItemReordered(
                              statusChatListItem.newCategoryId, 
                              statusChatListItem.chatId, 
                              statusChatListItem.originalOrder, 
                              statusChatListItem.newOrder
                            )
                        }
                        active = false
                    }
                    onMouseYChanged: {
                        if ((Math.abs(startY - mouseY) > 1) && pressed) {
                            active = true
                        }
                    }
                    onMouseXChanged: {
                        if ((Math.abs(startX - mouseX) > 1) && pressed) {
                            active = true
                        }
                    }

                    StatusChatListItem {

                        id: statusChatListItem

                        property string chatListId: statusChatList.uuid
                        property string profileImage: ""
                        property var newOrder: model.position
                        property var newCategoryId: model.categoryId

                        anchors.centerIn: parent
                        opacity: dragSensor.active ? 0.3 : 1.0
                        Component.onCompleted: {
                            if (typeof statusChatList.profileImageFn === "function") {
                                profileImage = statusChatList.profileImageFn(model.chatId || model.id) || ""
                            }
                        }
                        originalOrder: model.position
                        chatId: model.chatId || model.id
                        categoryId: model.categoryId || ""
                        /* name: (!!statusChatList.chatNameFn ? statusChatList.chatNameFn(model) : model.name) + " POSITION: " + statusChatListItem.newOrder */
                        name: (!!statusChatList.chatNameFn ? statusChatList.chatNameFn(model) : model.name)
                        type: model.chatType
                        muted: !!model.muted
                        hasUnreadMessages: !!model.hasUnreadMessages || model.unviewedMessagesCount > 0
                        hasMention: model.mentionsCount > 0
                        badge.value: model.chatType === StatusChatListItem.Type.OneToOneChat ?
                            model.unviewedMessagesCount || 0 :
                            model.mentionsCount || 0
                        selected: (model.chatId || model.id) === statusChatList.selectedChatId

                        icon.color: model.color || ""
                        image.isIdenticon: !!!profileImage && !!!model.identityImage && !!model.identicon
                        image.source: profileImage || model.identityImage || model.identicon || ""

                        sensor.cursorShape: dragSensor.cursorShape
                        onClicked: {
                            if (mouse.button === Qt.RightButton && !!statusChatList.popupMenu) {
                                statusChatListItem.highlighted = true

                                let originalOpenHandler = popupMenuSlot.item.openHandler
                                let originalCloseHandler = popupMenuSlot.item.closeHandler

                                popupMenuSlot.item.openHandler = function () {
                                    if (!!originalOpenHandler) {
                                        originalOpenHandler((model.chatId || model.id))
                                    }
                                }

                                popupMenuSlot.item.closeHandler = function () {
                                    if (statusChatListItem) {
                                        statusChatListItem.highlighted = false
                                    }
                                    if (!!originalCloseHandler) {
                                        originalCloseHandler()
                                    }
                                }

                                popupMenuSlot.item.popup(mouse.x + 4, statusChatListItem.y + mouse.y + 6)
                                popupMenuSlot.item.openHandler = originalOpenHandler
                                return
                            }
                            if (!statusChatListItem.selected) {
                                statusChatList.chatItemSelected(model.chatId || model.id)
                            }
                        }
                        onUnmute: statusChatList.chatItemUnmuted(model.chatId || model.id)

                        StatusChatListDropIndicator {
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: -2
                            visible: dropArea.containsDrag
                        }
                    }
                }
                DropArea {
                    id: dropArea
                    width: parent.width
                    height: parent.height
                    keys: ["chat-item"]

                    onEntered: reorderDelay.start()

                    Timer {
                        id: reorderDelay
                        interval: 100
                        repeat: false
                        onTriggered: {
                            if (dropArea.containsDrag) {
                                let newOrder = statusChatListItem.originalOrder

                                if (dropArea.drag.source.chatListItem.originalOrder > statusChatListItem.originalOrder) {
                                    newOrder = newOrder + 1
                                }
                                dropArea.drag.source.chatListItem.newOrder = newOrder
                                dropArea.drag.source.chatListItem.newCategoryId = statusChatListItem.categoryId
                            }
                        }
                    }
                }
                Loader {
                    id: draggedListItemLoader
                    active: dragSensor.active
                    sourceComponent: StatusChatListItem {
                        property string chatListId: draggable.chatListItem.chatListId
                        property var globalPosition: Utils.getAbsolutePosition(draggable)
                        parent: QC.Overlay.overlay
                        sensor.cursorShape: dragSensor.cursorShape
                        Drag.active: dragSensor.active
                        Drag.hotSpot.x: width / 2
                        Drag.hotSpot.y: height / 2
                        Drag.keys: ["chat-item"]
                        Drag.source: draggable

                        Component.onCompleted: {
                            x = globalPosition.x
                            y = globalPosition.y
                        }
                        chatId: draggable.chatListItem.chatId
                        categoryId: draggable.chatListItem.categoryId
                        name: draggable.chatListItem.name
                        type: draggable.chatListItem.type
                        muted: draggable.chatListItem.muted
                        dragged: true
                        hasUnreadMessages: draggable.chatListItem.hasUnreadMessages
                        hasMention: draggable.chatListItem.hasMention
                        badge.value: draggable.chatListItem.badge.value
                        selected: draggable.chatListItem.selected

                        icon.color: draggable.chatListItem.icon.color
                        image.isIdenticon: draggable.chatListItem.image.isIdenticon
                        image.source: draggable.chatListItem.image.source
                    }
                }
            }
        }
    }

    Loader {
        id: popupMenuSlot
        active: !!statusChatList.popupMenu
    }

    Loader {
        id: emptyListDropAreaLoader
        active: statusChatListItemsWrapper.implicitHeight == 0
        width: parent.width
        height: active ? 8 : 0
        sourceComponent: Item {
            width: statusChatList.width
            height: 8

            StatusChatListDropIndicator {
                visible: emptyListDropArea.containsDrag
                opacity: 0.5
                anchors.bottom: statusChatList.categoryId == "" ? parent.bottom : undefined
                anchors.top: statusChatList.categoryId !== "" ? parent.top : undefined
            }

            DropArea {
                id: emptyListDropArea
                anchors.fill: parent
                visible: parent.visible
                keys: ["chat-item"]
                onEntered: reorderDelay2.start()
                Timer {
                    id: reorderDelay2
                    interval: 100
                    repeat: false
                    onTriggered: {
                        if (emptyListDropArea.containsDrag) {
                            emptyListDropArea.drag.source.chatListItem.newOrder = 0
                            emptyListDropArea.drag.source.chatListItem.newCategoryId = statusChatList.categoryId
                        }
                    }
                }
            }
        }
    }
}
