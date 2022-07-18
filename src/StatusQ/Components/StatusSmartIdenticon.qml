import QtQuick 2.13
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Controls 0.1

Loader {
    id: root

    property string name: ""
    property int dZ: 100

    // Badge color properties must be set if badgeItem.visible = true
    property alias badge: statusBadge

    property StatusAssetSettings asset: StatusAssetSettings {
        width: 40
        height: 40
        imgWidth: 40
        imgHeight: 40
    }

    property StatusIdenticonRingSettings ringSettings: StatusIdenticonRingSettings {
        initalAngleRad: 0
        ringPxSize: Math.max(1.5, root.asset.imgWidth/ 24.0)
        distinctiveColors: Theme.palette.identiconRingColors
    }

    sourceComponent: root.asset.isLetterIdenticon ? letterIdenticon :
                     !!root.asset.imgSource.toString() ? roundedImage :
                     !!root.asset.name.toString() ? roundedIcon : letterIdenticon

    Component {
        id: roundedImage
        Item {
            width: root.asset.imgWidth
            height: root.asset.imgHeight
            StatusRoundedImage {
                id: statusRoundImage
                width: parent.width
                height: parent.height
                image.source: root.asset.imgSource
                showLoadingIndicator: true
                border.width: root.asset.imgIsIdenticon ? 1 : 0
                border.color: Theme.palette.directColor7
                color: root.asset.imgIsIdenticon ?
                           Theme.palette.statusRoundedImage.backgroundColor :
                           "transparent"
            }
            Loader {
                anchors.centerIn: parent
                active: root.asset.imgStatus === Image.Error
                sourceComponent: letterIdenticon
                onLoaded: {
                    item.color = Theme.palette.miscColor5
                    item.width = root.asset.imgWidth
                    item.height = root.asset.imgHeight
                }
            }
        }
    }

    Component {
        id: roundedIcon
        StatusRoundIcon {
            asset.bgWidth: root.asset.bgWidth
            asset.bgHeight: root.asset.bgHeight
            asset.bgColor: root.asset.bgColor
            asset.width: root.asset.width
            asset.height: root.asset.height
            asset.name: root.asset.name
            asset.rotation: root.asset.rotation
            asset.color: root.asset.color
        }
    }

    Component {
        id: letterIdenticon
        StatusLetterIdenticon {
            width: root.asset.width
            height: root.asset.height
            color: root.asset.color
            name: root.asset.name
            emoji: root.asset.emoji
            emojiSize: root.asset.emojiSize
            letterSize: root.asset.letterSize
            charactersLen: root.asset.charactersLen
        }
    }

    // Next components are painted above main sourceComponent
    StatusIdenticonRing {
        settings: root.ringSettings
        anchors.fill: parent
        z: root.dZ/2
    }

    // State component
    StatusBadge {
        id: statusBadge
        visible: false
        anchors.bottom: root.bottom
        anchors.right: root.right
        border.width: 3
        implicitHeight: 15
        implicitWidth: 15
        z: root.dZ
    }
}
