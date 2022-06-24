import QtQuick 2.14

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

Item {
    implicitHeight: Theme.dp(34)
    implicitWidth: Theme.dp(176)

    property alias text: label.text

    StatusBaseText {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.dp(4)
        anchors.leftMargin: Theme.dp(16)
        id: label
        font.pixelSize: Theme.dp(15)
        color: Theme.palette.baseColor1
    }
}
