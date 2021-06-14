import QtQuick 2.14

import StatusQ.Core 0.1
import StatusQ.Controls 0.1
import StatusQ.Popups 0.1

Column {
    spacing: 20

    StatusButton {
        text: "StatusModal"
        onClicked: modalExample.open()
    }

    StatusModal {
        id: modalExample
        anchors.centerIn: parent
        visible: true
        header.image.source: "https://pbs.twimg.com/profile_images/1369221718338895873/T_5fny6o_400x400.jpg"
        header.title: "Header"
        header.subTitle: "SubTitle"
        rightButtons: [
            StatusButton {
                text: "Button"
            },
            StatusButton {
                text: "Button"
            }
        ]

        leftButtons: [
            StatusRoundButton {
                icon.name: "arrow-right"
                rotation: 180
            }
        ]

        content: StatusBaseText {
            anchors.centerIn: parent
            text: "Some text content"
        }

        otherButton: StatusFlatRoundButton {
            type: StatusFlatRoundButton.Type.Secondary
            width: 32
            height: 32

            icon.width: 20
            icon.height: 20
            icon.name: "info"
        }
    }
}
