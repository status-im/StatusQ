import QtQuick 2.13
import QtQuick.Controls 2.13
import QtGraphicalEffects 1.13
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Components 0.1

TabButton {
    id: statusIconTabButton

    property string name: ""
    property bool highlighted: false

    property alias identicon: identicon

    implicitWidth: 40
    implicitHeight: 40

    icon.height: 24
    icon.width: 24
    icon.color: Theme.palette.baseColor1

    contentItem: Item {
        anchors.fill: parent
        StatusSmartIdenticon {
            id: identicon
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            asset.name: statusIconTabButton.icon.source.toString() !== "" ?
                        statusIconTabButton.icon.source : statusIconTabButton.icon.name
            asset.width: statusIconTabButton.icon.source.toString() !== "" ? 28 : statusIconTabButton.icon.width
            asset.height: statusIconTabButton.icon.source.toString() !== "" ? 28 : statusIconTabButton.icon.height
            asset.color: (statusIconTabButton.hovered || highlighted || statusIconTabButton.checked) ? Theme.palette.primaryColor1 : statusIconTabButton.icon.color
            asset.isLetterIdenticon: statusIconTabButton.name !== "" && !statusIconTabButton.icon.source.toString()
            name: statusIconTabButton.name
        }
    }

    background: Rectangle {
        color: hovered || highlighted || ((!!icon.source.toString() || !!name) && checked) ? Theme.palette.primaryColor3 : "transparent"
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

