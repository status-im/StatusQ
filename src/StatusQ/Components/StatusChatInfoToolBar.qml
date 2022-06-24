import QtQuick 2.13
import QtGraphicalEffects 1.13
import StatusQ.Components 0.1
import StatusQ.Controls 0.1
import StatusQ.Popups 0.1
import StatusQ.Core.Theme 0.1

Item {
    id: statusChatInfoToolBar

    implicitWidth: Theme.dp(288)
    implicitHeight: Theme.dp(56)

    property alias chatInfoButton: statusChatInfoButton
    property alias menuButton: statusMenuButton
    property Component popupMenu

    signal chatInfoButtonClicked()
    signal addButtonClicked(var mouse)

    onPopupMenuChanged: {
        if (!!popupMenu) {
            popupMenuSlot.sourceComponent = popupMenu
        }
    }

    StatusChatInfoButton {
        id: statusChatInfoButton
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: (implicitWidth > parent.width - Theme.dp(50)) ? statusMenuButton.left : undefined
        anchors.rightMargin: 5
        type: StatusChatInfoButton.Type.OneToOneChat
        onClicked: statusChatInfoToolBar.chatInfoButtonClicked()
    }

    StatusRoundButton {
        id: statusMenuButton
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        visible: popupMenuSlot.active
        width: visible ? Theme.dp(32) : 0
        height: Theme.dp(32)

        type: StatusRoundButton.Type.Secondary
        icon.name: "add"
        state: "default"

        states: [
            State {
                name: "default"
                PropertyChanges {
                    target: statusMenuButton
                    icon.rotation: 0
                }
            },
            State {
                name: "pressed"
                PropertyChanges {
                    target: statusMenuButton
                    icon.rotation: 45
                    highlighted: true
                }
            }
        ]

        transitions: [
            Transition {
                from: "default"
                to: "pressed"

                RotationAnimation {
                    duration: 150
                    direction: RotationAnimation.Clockwise
                    easing.type: Easing.InCubic
                }
            },
            Transition {
								from: "pressed"
								to: "default"
								RotationAnimation {
										duration: 150
										direction: RotationAnimation.Counterclockwise
										easing.type: Easing.OutCubic
								}
        		}
        ]

        onClicked: {
            statusChatInfoToolBar.addButtonClicked(mouse)
            statusMenuButton.state = "pressed"
            popupMenuSlot.item.popup(statusMenuButton.width-popupMenuSlot.item.width, statusMenuButton.height + Theme.dp(4))
        }

        Loader {
            id: popupMenuSlot
            active: !!statusChatInfoToolBar.popupMenu
            onLoaded: {
                popupMenuSlot.item.closeHandler = function () {
                    statusMenuButton.state = "default"
                }
            }
        }
    }
}
