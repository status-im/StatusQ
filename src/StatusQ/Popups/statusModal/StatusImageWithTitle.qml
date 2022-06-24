import QtQuick 2.14
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Components 0.1
import StatusQ.Controls 0.1

Row {
    id: statusImageWithTitle

    property alias title: headerTitle.text
    property alias subTitle: headerSubTitle.text
    property int titleElide: Text.ElideRight
    property int subTitleElide: Text.ElideRight
    property bool editable: false
    property bool headerImageEditable: false

    signal editButtonClicked
    signal headerImageClicked

    property StatusImageSettings image: StatusImageSettings {
        width: Theme.dp(40)
        height: Theme.dp(40)
        isIdenticon: false
    }

    property StatusIconSettings icon: StatusIconSettings {
        width: Theme.dp(40)
        height: Theme.dp(40)
        isLetterIdenticon: false
    }

    spacing: Theme.dp(8)

    Loader {
        id: iconOrImage
        anchors.verticalCenter: parent.verticalCenter
        width: active ? Theme.dp(40) : 0
        sourceComponent: {
            if (statusImageWithTitle.icon.isLetterIdenticon) {
                return statusLetterIdenticon
            }
            return statusRoundedImageCmp
        }
        active: statusImageWithTitle.icon.isLetterIdenticon ||
                !!statusImageWithTitle.image.source.toString()
    }

    Component {
        id: statusLetterIdenticon
        StatusLetterIdenticon {
            width: statusImageWithTitle.icon.width
            height: statusImageWithTitle.icon.height
            color: statusImageWithTitle.icon.background.color
            name: statusImageWithTitle.title
        }
    }

    Component {
        id: statusRoundedImageCmp
        Item {
            width: statusImageWithTitle.image.width
            height: statusImageWithTitle.image.height
            StatusRoundedImage {
                id: statusRoundedImage
                objectName: "headerImage"
                image.source:  statusImageWithTitle.image.source
                width: statusImageWithTitle.image.width
                height: statusImageWithTitle.image.height
                color: statusImageWithTitle.image.isIdenticon ?
                           Theme.palette.statusRoundedImage.backgroundColor :
                           "transparent"
                border.width: statusImageWithTitle.image.isIdenticon ? 1 : 0
                border.color: Theme.palette.directColor7
                showLoadingIndicator: true
            }

            Rectangle {
                id: editAvatarIcon

                objectName: "editAvatarImage"
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: -Theme.dp(3)
                anchors.rightMargin: -Theme.dp(2)
                width: Theme.dp(18)
                height: Theme.dp(18)
                radius: width / 2

                visible: statusImageWithTitle.headerImageEditable

                color: Theme.palette.primaryColor1;
                border.color: Theme.palette.indirectColor1
                border.width: Theme.palette.name === "light" ? 1 : 0

                StatusIcon {
                    anchors.centerIn: parent
                    width: Theme.dp(11)
                    color: Theme.palette.indirectColor1
                    icon: "tiny/edit"
                }
            }

            MouseArea {
                anchors.fill: parent

                cursorShape: enabled ? Qt.PointingHandCursor
                                     : Qt.ArrowCursor
                enabled: statusImageWithTitle.headerImageEditable

                onClicked: {
                    statusImageWithTitle.headerImageClicked()
                }
            }

            Loader {
                sourceComponent: statusLetterIdenticon
                active: statusRoundedImage.image.status === Image.Error
            }
        }
    }

    Column {
        id: textLayout
        width: !iconOrImage.active ? parent.width :
                                     parent.width - iconOrImage.width - parent.spacing
        Row {
            id: headerTitleRow
            width: parent.width
            spacing: Theme.dp(4)
            StatusBaseText {
                id: headerTitle
                objectName: "headerTitle"
                font.family: Theme.palette.baseFont.name
                font.pixelSize: Theme.dp(17)
                font.bold: true
                elide: statusImageWithTitle.titleElide
                color: Theme.palette.directColor1
                width: implicitWidth > parent.width - editButton.width ? parent.width - editButton.width: implicitWidth
            }
            StatusFlatRoundButton {
                id: editButton
                objectName: "editAvatarbButton"
                visible: statusImageWithTitle.editable
                anchors.verticalCenter: headerTitle.verticalCenter
                height: Theme.dp(24)
                width: visible ? Theme.dp(24) : 0
                type: StatusFlatRoundButton.Type.Secondary
                icon.name: "pencil"
                icon.color: Theme.palette.directColor1
                icon.width: Theme.dp(13)
                icon.height: Theme.dp(13)

                onClicked: statusImageWithTitle.editButtonClicked()
            }
        }

        StatusBaseText {
            id: headerSubTitle
            objectName: "headerSubTitle"
            font.family: Theme.palette.baseFont.name
            font.pixelSize: Theme.dp(15)
            color:Theme.palette.baseColor1
            width: parent.width
            elide: statusImageWithTitle.subTitleElide
            visible: !!statusImageWithTitle.subTitle
        }
    }
}
