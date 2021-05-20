import QtQuick 2.13
import StatusQ.Components 0.1
import StatusQ.Controls 0.1
    
StatusIconTabButton {
    id: statusNavBarTabButton 
    property alias badge: statusBadge
    property alias tooltip: statusTooltip
    signal clicked(var mouse)

    StatusToolTip {
        id: statusTooltip
        visible: statusNavBarTabButton.hovered && !!statusTooltip.text
        delay: 50
        orientation: StatusToolTip.Orientation.Right
        x: statusNavBarTabButton.width + 16
        y: statusNavBarTabButton.height / 2 - height / 2 + 4
    }

    StatusBadge {
        id: statusBadge
        visible: value > 0
        anchors.top: parent.top
        anchors.left: parent.right
        anchors.leftMargin: {
            if (statusBadge.value > 99) {
                return -22
            }
            if (statusBadge.value > 9) {
                return -21
            }
            return -18
        }
        anchors.topMargin: 4
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: function (mouse) {
            statusNavBarTabButton.checked = !statusNavBarTabButton.checked
            statusNavBarTabButton.clicked(mouse)
        }
    }
}
