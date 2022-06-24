import QtQuick 2.14

import StatusQ.Core 0.1
import StatusQ.Controls 0.1
import StatusQ.Core.Theme 0.1

Item {
    id: root
    width: Theme.dp(800)
    height: Theme.dp(100)

    Row {
        id: selectedColor
        anchors.top: parent.top
        anchors.left: colorSelectionGrid.left
        spacing: Theme.dp(10)
        StatusBaseText {
            text: "SelectedColor is"
        }
        Rectangle {
            width: Theme.dp(100)
            height: Theme.dp(20)
            radius: width/2
            color: colorSelectionGrid.selectedColor
        }
    }

    StatusColorSelectorGrid {
        id: colorSelectionGrid
        anchors.top: selectedColor.bottom
        anchors.topMargin: Theme.dp(10)
        anchors.horizontalCenter: parent.horizontalCenter
        titleText: "COLOR"
        selectedColorIndex: 2
    }
}
