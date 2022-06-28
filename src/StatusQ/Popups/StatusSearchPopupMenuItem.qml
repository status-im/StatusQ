import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import StatusQ.Components 0.1
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

MenuItem {
    id: root
    implicitHeight: Theme.dp(38)

    property string value: ""

    property StatusImageSettings image: StatusImageSettings {
        height: Theme.dp(16)
        width: Theme.dp(16)
        isIdenticon: false
    }

    property StatusIconSettings iconSettings: StatusIconSettings {
        height: Theme.dp(16)
        width: Theme.dp(16)
        isLetterIdenticon: (root.image.source.toString() === ""
                            && root.iconSettings.name.toString() === "")
        background: StatusIconBackgroundSettings {}
        color: (name === "channel") ? Theme.palette.directColor1 : "transparent"
        letterSize: Theme.dp(charactersLen > 1 ? 8 : 11)
    }

    property alias ringSettings: identicon.ringSettings

    background: Rectangle {
        color: root.hovered ? Theme.palette.statusPopupMenu.hoverBackgroundColor : "transparent"
    }

    contentItem: RowLayout {
        anchors.left: parent.left
        anchors.leftMargin: Theme.dp(12)
        Item {
            Layout.preferredWidth: root.iconSettings.width
            Layout.preferredHeight: root.iconSettings.height
            Layout.alignment: Qt.AlignVCenter
            StatusSmartIdenticon {
                id: identicon
                anchors.centerIn: parent
                image: root.image
                icon: root.iconSettings
                name: root.text
                ringSettings: root.ringSettings
            }
        }
        StatusBaseText {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            text: root.text
            color: Theme.palette.directColor1
            font.pixelSize: 13
            elide: Text.ElideRight
        }
        Item {
            Layout.fillWidth: true
        }
    }
    MouseArea {
        id: sensor
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onPressed: mouse.accepted = false
    }
}
