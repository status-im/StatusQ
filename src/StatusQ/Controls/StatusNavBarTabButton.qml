import QtQuick 2.13
import StatusQ.Components 0.1
import StatusQ.Controls 0.1
import StatusQ.Popups 0.1
import StatusQ.Core.Theme 0.1
    
StatusIconTabButton {
    id: statusNavBarTabButton 
    property alias badge: statusBadge
    property alias tooltip: statusTooltip
    property Component popupMenu

    signal clicked(var mouse)

    onPopupMenuChanged: {
        if (!!popupMenu) {
            popupMenuSlot.sourceComponent = popupMenu
        }
    }

    StatusToolTip {
        id: statusTooltip
        visible: statusNavBarTabButton.hovered && !!statusTooltip.text
        delay: 50
        orientation: StatusToolTip.Orientation.Right
        x: statusNavBarTabButton.width + Theme.dp(16)
        y: statusNavBarTabButton.height / 2 - height / 2 + Theme.dp(4)
    }

    StatusBadge {
        id: statusBadge
        visible: value > 0
        anchors.top: parent.top
        anchors.left: parent.right
        anchors.leftMargin: {
            if (statusBadge.value > Theme.dp(99)) {
                return -Theme.dp(22)
            }
            if (statusBadge.value > Theme.dp(9)) {
                return -Theme.dp(21)
            }
            return -Theme.dp(18)
        }
        anchors.topMargin: Theme.dp(4)
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {
            if (mouse.button === Qt.RightButton) {
                if (popupMenuSlot.active) {
                    statusNavBarTabButton.highlighted = true
                    let btnWidth = statusNavBarTabButton.width
                    popupMenuSlot.item.popup(parent.x + btnWidth + 4, -2)
                    return
                }
            }
            statusNavBarTabButton.clicked(mouse)
        }
    }

    Loader {
        id: popupMenuSlot
        active: !!statusNavBarTabButton.popupMenu
        onLoaded: {
            popupMenuSlot.item.closeHandler = function () {
                statusNavBarTabButton.highlighted = false
            }
        }
    }
}

