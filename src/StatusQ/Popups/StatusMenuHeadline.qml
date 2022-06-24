import QtQuick 2.13
import QtQuick.Controls 2.13

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

MenuSeparator {
    id: root
    property string text
    height: visible && enabled ? implicitHeight : 0
    contentItem: Item {
        implicitWidth: Theme.dp(176)
        implicitHeight: Theme.dp(16)
        StatusBaseText {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: Theme.dp(12)
            color: Theme.palette.baseColor1
            font.pixelSize: Theme.dp(12)
            text: root.text
        }
    }
}

