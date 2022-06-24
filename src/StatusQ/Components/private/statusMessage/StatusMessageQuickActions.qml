import QtQuick 2.13
import QtGraphicalEffects 1.13
import QtQuick.Layouts 1.14

import StatusQ.Controls 0.1
import StatusQ.Core.Theme 0.1

Rectangle {
    id: buttonsContainer

    property list<Item> quickActions

    QtObject {
        id: _internal
        readonly property int containerMargin: 2
    }

    width: buttonRow.width + _internal.containerMargin * 2
    height: Theme.dp(36)
    radius: Theme.dp(8)
    color: Theme.palette.statusSelect.menuItemBackgroundColor

    layer.enabled: true
    layer.effect: DropShadow {
        width: buttonsContainer.width
        height: buttonsContainer.height
        x: buttonsContainer.x
        y: buttonsContainer.y + Theme.dp(10)
        horizontalOffset: 0
        verticalOffset: Theme.dp(2)
        source: buttonsContainer
        radius: Theme.dp(10)
        samples: 15
        color: Theme.palette.dropShadow
    }

    Row {
        id: buttonRow
        spacing: _internal.containerMargin
        anchors.left: parent.left
        anchors.leftMargin: _internal.containerMargin
        anchors.verticalCenter: buttonsContainer.verticalCenter
        height: parent.height - 2 * _internal.containerMargin
    }

    onQuickActionsChanged: {
        for (let idx in quickActions) {
            quickActions[idx].parent = buttonRow
        }
    }
}
