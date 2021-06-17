import QtQuick 2.14
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Components 0.1
import StatusQ.Controls 0.1

Row {
    id: statusImageWithTitle

    property alias title: headerTitle.text
    property alias subTitle: headerSubTitle.text

    signal editClicked

    property StatusImageSettings image: StatusImageSettings {
        width: 40
        height: 40
    }

    spacing: 8

    StatusRoundedImage {
        id: headerImage
        anchors.verticalCenter: parent.verticalCenter
        width: statusImageWithTitle.image.width
        height: statusImageWithTitle.image.height
        image.source:  statusImageWithTitle.image.source
    }

    Column {
        id: textLayout

        Row {
            spacing: 4
            StatusBaseText {
                id: headerTitle
                font.family: Theme.palette.baseFont.name
                font.pixelSize: 17
                font.bold: true
                color: Theme.palette.directColor1
            }
            StatusFlatRoundButton {
                id: editButton
                anchors.bottom: headerTitle.bottom
                anchors.bottomMargin: -1
                height: 24
                width: 24
                type: StatusFlatRoundButton.Type.Secondary
                icon.name: "pencil"
                icon.color: Theme.palette.directColor1
                icon.width: 12.5
                icon.height: 12.5

                onClicked: statusImageWithTitle.editClicked()
            }
        }

        StatusBaseText {
            id: headerSubTitle
            font.family: Theme.palette.baseFont.name
            font.pixelSize: 15
            color:Theme.palette.baseColor1
        }
    }
}
