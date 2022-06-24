import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

Item {
    id: statusAppTwoPanelLayout

    implicitWidth: Theme.dp(822)
    implicitHeight: Theme.dp(600)

    property Item leftPanel
    property Item rightPanel

    onLeftPanelChanged: {
        if (!!leftPanel) {
            leftPanel.parent = leftPanelSlot
        }
    }

    onRightPanelChanged: {
        if (!!rightPanel) {
            rightPanel.parent = rightPanelSlot
        }
    }

    Row {
        anchors.fill: parent

        Rectangle {
            id: leftPanelSlot
            height: parent.height
            width: Theme.dp(304)
            color: Theme.palette.baseColor4
        }

        Rectangle {
            id: rightPanelSlot
            height: parent.height
            width: parent.width - leftPanelSlot.width
            color: Theme.palette.statusAppLayout.rightPanelBackgroundColor
        }
    }
}
