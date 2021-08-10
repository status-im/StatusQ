import QtQuick 2.13
import QtQml.Models 2.13
import QtQuick.Controls 2.13 as QC
import QtGraphicalEffects 1.13

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Components 0.1
import StatusQ.Controls 0.1

Rectangle {
    id: statusChatListItem

    objectName: "chatItem"
    property int originalOrder: -1
    property string chatId: ""
    property string name: ""
    property alias badge: statusBadge
    property bool hasUnreadMessages: false
    property bool hasMention: false
    property bool muted: false
    property StatusImageSettings image: StatusImageSettings {}
    property StatusIconSettings icon: StatusIconSettings {
        color: Theme.palette.miscColor5
    }
    property int type: StatusChatListItem.Type.PublicChat
    property bool highlighted: false
    property bool selected: false

    signal clicked(var mouse)
    signal unmute()

    signal visualReorder(int from, int to, int order)
    signal reorder(int from, int to)

    enum Type {
        Unknown0, // 0
        OneToOneChat, // 1
        PublicChat, // 2
        GroupChat, // 3
        Unknown1, // 4
        Unknown2, // 5
        CommunityChat // 6
    }

    implicitWidth: 288
    implicitHeight: 40

    radius: 8

    color: {
        if (selected) {
            return Theme.palette.statusChatListItem.selectedBackgroundColor
        }
        return sensor.containsMouse || highlighted ? Theme.palette.statusChatListItem.hoverBackgroundColor : Theme.palette.baseColor4
    }

    opacity: sensor.held ? 0.0 : 1.0

    Behavior on y { NumberAnimation { duration: 350 }}

    MouseArea {
        id: sensor

        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        hoverEnabled: true

        property bool held: false

        drag.target: content.item

        property real startY: 0
        onMouseYChanged: {
            if ( (Math.abs(startY - mouseY) > 5 ) && pressed) {
                held = true
            }
        }
        onPressed: startY = mouseY
        onPressAndHold: {
            held = true
        }

        onReleased: {
            if (held) {
                reorder(statusChatListItem.originalOrder, statusChatListItem.originalOrder)
            }
            held = false
        }

        onClicked: statusChatListItem.clicked(mouse)

        Loader {
            id: identicon
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter

            sourceComponent: !!statusChatListItem.image.source.toString() ?
                                 statusRoundedImageCmp : statusLetterIdenticonCmp
        }

        Component {
            id: statusLetterIdenticonCmp
            StatusLetterIdenticon {
                height: 24
                width: 24
                name: statusChatListItem.name
                letterSize: 15
                color: statusChatListItem.icon.color
            }
        }

        Component {
            id: statusRoundedImageCmp
            Item {
                height: 24
                width: 24
                StatusRoundedImage {
                    id: statusRoundedImage
                    width: parent.width
                    height: parent.height
                    image.source: statusChatListItem.image.source
                    showLoadingIndicator: true
                    color: statusChatListItem.image.isIdenticon ?
                               Theme.palette.statusRoundedImage.backgroundColor :
                               "transparent"
                    border.width: statusChatListItem.image.isIdenticon ? 1 : 0
                    border.color: Theme.palette.directColor7
                }

                Loader {
                    sourceComponent: statusLetterIdenticonCmp
                    active: statusRoundedImage.image.status === Image.Error
                }
            }
        }

        StatusIcon {
            id: statusIcon
            anchors.left: identicon.right
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter

            width: 14
            visible: statusChatListItem.type !== StatusChatListItem.Type.OneToOneChat
            opacity: {
                if (statusChatListItem.muted && !sensor.containsMouse && !statusChatListItem.highlighted) {
                    return 0.4
                }
                return statusChatListItem.hasMention ||
                        statusChatListItem.hasUnreadMessages ||
                        statusChatListItem.selected ||
                        statusChatListItem.highlighted ||
                        statusBadge.visible ||
                        sensor.containsMouse ? 1.0 : 0.7
            }

            icon: {
                switch (statusChatListItem.type) {
                case StatusChatListItem.Type.PublicCat:
                    return Theme.palette.name == "light" ? "tiny/public-chat" : "tiny/public-chat-white"
                    break;
                case StatusChatListItem.Type.GroupChat:
                    return Theme.palette.name == "light" ? "tiny/group" : "tiny/group-white"
                    break;
                case StatusChatListItem.Type.CommunityChat:
                    return Theme.palette.name == "light" ? "tiny/channel" : "tiny/channel-white"
                    break;
                default:
                    return Theme.palette.name == "light" ? "tiny/public-chat" : "tiny/public-chat-white"
                }
            }
        }

        StatusBaseText {
            id: chatName
            anchors.left: statusIcon.visible ? statusIcon.right : identicon.right
            anchors.leftMargin: statusIcon.visible ? 1 : 8
            anchors.right: mutedIcon.visible ? mutedIcon.left :
                                               statusBadge.visible ? statusBadge.left : parent.right
            anchors.rightMargin: 6
            anchors.verticalCenter: parent.verticalCenter

            text: originalOrder + (statusChatListItem.type === StatusChatListItem.Type.PublicChat &&
                  !statusChatListItem.name.startsWith("#") ?
                      "#" + statusChatListItem.name :
                      statusChatListItem.name)
            elide: Text.ElideRight
            color: {
                if (statusChatListItem.muted && !sensor.containsMouse && !statusChatListItem.highlighted) {
                    return Theme.palette.directColor5
                }
                return statusChatListItem.hasMention ||
                        statusChatListItem.hasUnreadMessages ||
                        statusChatListItem.selected ||
                        statusChatListItem.highlighted ||
                        sensor.containsMouse ||
                        statusBadge.visible ? Theme.palette.directColor1 : Theme.palette.directColor4
            }
            font.weight: !statusChatListItem.muted &&
                         (statusChatListItem.hasMention ||
                          statusChatListItem.hasUnreadMessages ||
                          statusBadge.visible) ? Font.Bold : Font.Medium
            font.pixelSize: 15
        }

        StatusIcon {
            id: mutedIcon
            anchors.right: statusBadge.visible ? statusBadge.left : parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            width: 14
            opacity: mutedIconSensor.containsMouse ? 1.0 : 0.2
            icon: Theme.palette.name === "light" ? "tiny/muted" : "tiny/muted-white"
            visible: statusChatListItem.muted

            MouseArea {
                id: mutedIconSensor
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: statusChatListItem.unmute()
            }

            StatusToolTip {
                text: "Unmute"
                visible: mutedIconSensor.containsMouse
            }
        }

        StatusBadge {
            id: statusBadge

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 8

            color: statusChatListItem.muted ? Theme.palette.primaryColor2 : Theme.palette.primaryColor1
            border.width: 4
            border.color: color
            visible: statusBadge.value > 0
        }
    }

    DropArea {
        id: dropArea
        width: sensor.held ? 0 : parent.width
        height: sensor.held ? 0 : parent.height
        keys: ["chat"]
        onEntered: {
            reorderDelay.start()
        }

        onDropped: {
            reorder(drag.source.originalOrder, statusChatListItem.DelegateModel.itemsIndex)
        }

        Timer {
            id: reorderDelay
            interval: 100
            repeat: false
            onTriggered: {
                if (dropArea.containsDrag) {
                    dropArea.drag.source.originalOrder = statusChatListItem.originalOrder
                    visualReorder(dropArea.drag.source.DelegateModel.itemsIndex, statusChatListItem.DelegateModel.itemsIndex, statusChatListItem.originalOrder)
                }
            }
        }
    }

    Loader {
        id:content
        active: sensor.held
        sourceComponent: Item {
            property var globalPosition: getAbsolutePosition(statusChatListItem)
            parent: QC.Overlay.overlay
            width: statusChatListItem.width
            height: statusChatListItem.height
            Drag.active: sensor.held
            Drag.hotSpot.x: width / 2
            Drag.hotSpot.y: height / 2
            Drag.keys: ["chat"]
            Drag.source: statusChatListItem
            Component.onCompleted: {
                x = globalPosition.x
                y = globalPosition.y
            }

            RectangularGlow {
                anchors.fill: cover
                color: "#22000000"
                glowRadius: 8
                cornerRadius: 8
            }
            Rectangle {
                id: cover
                anchors.fill: parent
                color: Theme.palette.baseColor4
                radius: 8

                Row {
                    spacing: 6
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    Loader {
                        id: iconLoader
                        anchors.verticalCenter: parent.verticalCenter
                        sourceComponent: !!statusChatListItem.image.source.toString() ?
                                             statusRoundedImageCmp : statusLetterIdenticonCmp
                    }

                    StatusBaseText {
                        anchors.verticalCenter: parent.verticalCenter
                        width: cover.width - iconLoader.item.width - 22
                        text: chatName.text
                        elide: Text.ElideRight
                        color: Theme.palette.directColor5
                    }
                }
            }

            function getAbsolutePosition(node) {
                var returnPos = {};
                returnPos.x = 0;
                returnPos.y = 0;
                if (node !== undefined && node !== null) {
                    var parentValue = getAbsolutePosition(node.parent);
                    returnPos.x = parentValue.x + node.x;
                    returnPos.y = parentValue.y + node.y;
                }
                return returnPos;
            }
        }
    }

}
