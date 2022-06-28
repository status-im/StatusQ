import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

Rectangle {
    id: root
    width: layout.width + layout.anchors.margins
    height: Theme.dp(30)
    color: Theme.palette.primaryColor3
    radius: Theme.dp(15)

    property alias titleText: titleText

    property string title: ""
    property bool closeButtonVisible: true
    signal clicked()

    property StatusImageSettings image: StatusImageSettings {
        width: Theme.dp(20)
        height: Theme.dp(20)
        isIdenticon: false
    }

    property StatusIconSettings icon: StatusIconSettings {
        height: Theme.dp(20)
        width: Theme.dp(20)
        rotation: 0
        isLetterIdenticon: false
        letterSize: Theme.dp(10)
        color: Theme.palette.primaryColor1
        background: StatusIconBackgroundSettings {
            width: Theme.dp(15)
            height: Theme.dp(15)
            color: Theme.palette.primaryColor3
        }
    }

    RowLayout {
        id: layout
        height: parent.height
        anchors.margins: Theme.dp(6)

        StatusSmartIdenticon {
            id: iconOrImage
            Layout.leftMargin: Theme.dp(4)
            image: root.image
            icon: root.icon
            name: root.title
            active: root.icon.isLetterIdenticon ||
                    !!root.icon.name ||
                    !!root.image.source.toString()
        }

        StatusBaseText {
            id: titleText
            color: Theme.palette.primaryColor1
            text: root.title
            Layout.rightMargin: closeButtonVisible ? 0 : Theme.dp(5)
        }

        StatusIcon {
            id: closeIcon
            color: Theme.palette.primaryColor1
            icon: "close-circle"
            visible: closeButtonVisible
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    root.clicked()
                }
            }
        }
    }
}
