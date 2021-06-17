import QtQuick 2.14
import QtQuick.Layouts 1.14

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Components 0.1
import StatusQ.Controls 0.1


Rectangle {
    id: statusModalFooter

    property list<Item> leftButtons
    property list<StatusBaseButton> rightButtons

    radius: 16

    color: Theme.palette.indirectColor1

    onLeftButtonsChanged: {
        for (let idx in leftButtons) {
            leftButtons[idx].parent = leftButtonsLayout
        }
    }

    onRightButtonsChanged: {
        for (let idx in rightButtons) {
            rightButtons[idx].parent = rightButtonsLayout
        }
    }

    implicitHeight: rootLayout.implicitHeight + 30

    RowLayout {
        id: rootLayout
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 16
        anchors.rightMargin: 18

        Row {
            id: leftButtonsLayout
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft

            spacing: 16
        }

        Item {
            Layout.fillWidth: true
            implicitHeight: 1
        }

        Row {
            id: rightButtonsLayout
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight

            spacing: 16

        }
    }

    Rectangle {
        anchors.top: parent.top
        width: parent.width
        height: parent.radius
        color: parent.color
    }
}
