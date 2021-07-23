import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import StatusQ.Components 0.1
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

MenuItem {
    id: root
    implicitHeight: 38
    property StatusImageSettings image: StatusImageSettings {
        height: 16
        width: 16
        isIdenticon: false
    }
    property StatusIconSettings iconSettings: StatusIconSettings {
        height: 16
        width: 16
        isLetterIdenticon: !!root.image.source
        background: StatusIconBackgroundSettings {}
        color: "transparent"
    }
    background: Rectangle {
        color: sensor.hovered ? Theme.palette.statusPopupMenu.hoverBackgroundColor : "transparent"
    }
    contentItem: RowLayout {
        StatusIcon {
            Layout.preferredWidth: root.iconSettings.width
            Layout.preferredHeight: root.iconSettings.height
            Layout.alignment: Qt.AlignVCenter
            visible: !!icon
            icon:  root.icon.name
            color: root.icon.color
        }
        StatusRoundedImage {
            Layout.preferredWidth: root.image.width
            Layout.preferredHeight: root.image.height
            Layout.alignment: Qt.AlignVCenter
            visible: !!root.image.source
            image.source: root.image.source
            border.width: root.image.isIdenticon ? 1 : 0
            border.color: Theme.palette.directColor7
        }
        StatusBaseText {
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
        onClicked: {
            root.clicked();
        }
    }
}
