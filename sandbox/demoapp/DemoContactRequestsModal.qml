import QtQuick 2.12

import StatusQ.Controls 0.1
import StatusQ.Core 0.1
import StatusQ.Popups 0.1
import StatusQ.Core.Theme 0.1

StatusModal {
    id: root

    header.title: "Contact Requests"
    headerActionButton: StatusFlatRoundButton {
        type: StatusFlatRoundButton.Type.Secondary
        width: Theme.dp(32)
        height: Theme.dp(32)

        icon.width: Theme.dp(20)
        icon.height: Theme.dp(20)
        icon.name: "notification"
    }

    contentItem: StatusBaseText {
        anchors.centerIn: parent
        text: "Contact request will be shown here"
        font.pixelSize: Theme.dp(15)
        color: Theme.palette.directColor1
    }

    rightButtons: [
        StatusButton {
            text: "Decline all"
            type: StatusBaseButton.Type.Danger
            onClicked: root.close()
        },
        StatusButton {
            text: "Accept all"
            onClicked: root.close()
        }
    ]
}
