import QtQuick 2.13
import QtQuick.Controls 2.13
import QtGraphicalEffects 1.13
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Components 0.1

TabButton {
    id: statusIconTabButton

    property string name: ""

    implicitWidth: 40
    implicitHeight: 40

    icon.height: 24
    icon.width: 24
    icon.color: Theme.palette.baseColor1

    contentItem: Item {
        anchors.fill: parent

        Loader {
            active: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            sourceComponent: statusIconTabButton.name !== "" && !icon.source.toString() ? letterIdenticon :
              !!icon.source.toString() ? imageIcon : defaultIcon
        }

        Component {
            id: defaultIcon
            StatusIcon {
                icon: statusIconTabButton.icon.name
                height: statusIconTabButton.icon.height
                width: statusIconTabButton.icon.width
                color: (statusIconTabButton.hovered || statusIconTabButton.checked) ? Theme.palette.primaryColor1 : statusIconTabButton.icon.color
            }
        }

        Component {
            id: imageIcon
            Item {
                width: 28
                height: 28
                StatusRoundedImage {
                    id: statusRoundImage
                    width: parent.width
                    height: parent.height
                    image.source: icon.source
                }
                Loader {
                    sourceComponent: {
                        if (statusRoundImage.image.status === Image.Loading) {
                            return statusLoadingIndicator
                        }
                        if (statusRoundImage.image.status === Image.Error) {
                            return letterIdenticon
                        }
                    }
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    active: statusRoundImage.image.status === Image.Loading || statusRoundImage.image.status === Image.Error
                }

                Component {
                    id: statusLoadingIndicator
                    StatusLoadingIndicator {
                        color: Theme.palette.directColor6
                    }
                }
            }
        }

        Component {
            id: letterIdenticon
            StatusLetterIdenticon {
                width: 26
                height: 26
                letterSize: 15
                name: statusIconTabButton.name
                color: (statusIconTabButton.hovered || statusIconTabButton.checked) ? Theme.palette.primaryColor1 : statusIconTabButton.icon.color
            }
        }
    }

    background: Rectangle {
        color: hovered || ((!!icon.source.toString() || !!name) && checked) ? Theme.palette.primaryColor3 : "transparent"
        border.color: Theme.palette.primaryColor1
        border.width: (!!icon.source.toString() || !!name) && checked ? 1 : 0
        radius: statusIconTabButton.width / 2
    }

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        onPressed: mouse.accepted = false
    }
}

