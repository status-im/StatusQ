import QtQuick 2.14
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.13

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1

TabButton {
    id: control
    contentItem: Item {
        height: 36
        MouseArea {
            id: sensor
            hoverEnabled: true
            anchors.fill: parent
            cursorShape: control.hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
            onClicked: control.checked = true

            StatusBaseText {
                id: label
                text: control.text
                color: Theme.palette.primaryColor1
                font.weight: Font.Medium
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
            }
        }
    }

    background: Rectangle {
        id: controlBackground
        implicitHeight: 36
        implicitWidth: 148
        color: control.checked ? 
            Theme.palette.statusSwitchTab.backgroundColor :
            "transparent"
        radius: 8
        layer.enabled: true
        layer.effect: DropShadow {
            width: controlBackground.width
            height: controlBackground.height
            x: controlBackground.x
            source: controlBackground
            horizontalOffset: 0
            verticalOffset: 0
            radius: 10
            samples: 25
            spread: 0
            color: Theme.palette.dropShadow
        }
    }
}
