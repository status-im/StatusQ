import QtQuick 2.13
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

Loader {
    id: statusSmartIdenticon

    property string name: ""

    property StatusIconSettings icon: StatusIconSettings {
        width: 40
        height: 40
    }

    property StatusImageSettings image: StatusImageSettings {
        width: 40
        height: 40
    }

    sourceComponent: statusSmartIdenticon.icon.isLetterIdenticon ? letterIdenticon :
                     !!statusSmartIdenticon.image.source.toString() ? roundedImage :
                     !!statusSmartIdenticon.icon.name.toString() ? roundedIcon : letterIdenticon

    Component {
        id: roundedImage
        Item {
            width: statusSmartIdenticon.image.width
            height: statusSmartIdenticon.image.height
            StatusRoundedImage {
                id: statusRoundImage
                width: parent.width
                height: parent.height
                image.source: statusSmartIdenticon.image.source
                showLoadingIndicator: true
                border.width: statusSmartIdenticon.image.isIdenticon ? 1 : 0
                border.color: Theme.palette.directColor7
                color: statusSmartIdenticon.image.isIdenticon ?
                           Theme.palette.statusRoundedImage.backgroundColor :
                           "transparent"
            }
            Loader {
                anchors.centerIn: parent
                active: statusRoundImage.image.status === Image.Error
                sourceComponent: letterIdenticon
                onLoaded: {
                    item.color = Theme.palette.miscColor5
                    item.width = statusSmartIdenticon.image.width
                    item.height = statusSmartIdenticon.image.height
                }
            }
        }
    }

    Component {
        id: roundedIcon
        StatusRoundIcon {
            icon.background.width: statusSmartIdenticon.icon.background.width
            icon.background.height: statusSmartIdenticon.icon.background.height
            icon.background.color: statusSmartIdenticon.icon.background.color
            icon.width: statusSmartIdenticon.icon.width
            icon.height: statusSmartIdenticon.icon.height
            icon.name: statusSmartIdenticon.icon.name
            icon.rotation: statusSmartIdenticon.icon.rotation
            icon.color: statusSmartIdenticon.icon.color
        }
    }

    Component {
        id: letterIdenticon
        StatusLetterIdenticon {
            width: statusSmartIdenticon.icon.width
            height: statusSmartIdenticon.icon.height
            color: statusSmartIdenticon.icon.color
            name: statusSmartIdenticon.name
            letterSize: statusSmartIdenticon.icon.letterSize
        }
    }
}