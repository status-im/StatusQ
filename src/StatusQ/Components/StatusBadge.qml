import QtQuick 2.13
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

Rectangle {
    id: statusBadge

    property int value

    implicitHeight: statusBadge.value > 0 ? Theme.dp(18) + statusBadge.border.width : Theme.dp(10) + statusBadge.border.width
    implicitWidth: {
        if (statusBadge.value > Theme.dp(99)) {
            return Theme.dp(28) + statusBadge.border.width
        }
        if (statusBadge.value > Theme.dp(9)) {
            return Theme.dp(26) + statusBadge.border.width
        }
        if (statusBadge.value > 0) {
            return Theme.dp(18) + statusBadge.border.width
        }
        return Theme.dp(10) + statusBadge.border.width
    }
    radius: height / 2
    color: Theme.palette.primaryColor1

    StatusBaseText {
        id: value
        visible: statusBadge.value > 0
        font.pixelSize: statusBadge.value > Theme.dp(99) ? Theme.dp(10) : Theme.dp(12)
        font.weight: Font.Medium
        color: Theme.palette.statusBadge.foregroundColor
        anchors.centerIn: parent
        text: {
            if (statusBadge.value > 99) {
                return qsTr("99+");
            }
            return statusBadge.value;
        }
    }
}
